Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266081AbUFPCxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266081AbUFPCxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 22:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266089AbUFPCxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:53:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31914 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266108AbUFPCtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:49:22 -0400
Date: Tue, 15 Jun 2004 22:49:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 1/4] Fine-grained Netlink support - SELinux headers
 update
In-Reply-To: <Xine.LNX.4.44.0406152216030.30562@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0406152226150.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch regenerates the SELinux module headers to reflect new class
and access vectors definitions.  The size of the diff is misleading;
much of it is simply a change in the ordering of the automatically
generated definitions. The corresponding generation script has been
changed to ensure a stable order in the future.  Please apply.

Please apply.

Author: Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/include/av_perm_to_string.h |   92 ++++
 security/selinux/include/av_permissions.h    |  600 +++++++++++++++------------
 security/selinux/include/class_to_string.h   |   12 
 security/selinux/include/flask.h             |   12 
 4 files changed, 463 insertions(+), 253 deletions(-)


Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.11
diff -u -r1.11 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	10 May 2004 13:01:08 -0000	1.11
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	26 May 2004 15:36:03 -0000
@@ -30,6 +30,9 @@
    { SECCLASS_TCP_SOCKET, TCP_SOCKET__CONNECTTO, "connectto" },
    { SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn" },
    { SECCLASS_TCP_SOCKET, TCP_SOCKET__ACCEPTFROM, "acceptfrom" },
+   { SECCLASS_TCP_SOCKET, TCP_SOCKET__NODE_BIND, "node_bind" },
+   { SECCLASS_UDP_SOCKET, UDP_SOCKET__NODE_BIND, "node_bind" },
+   { SECCLASS_RAWIP_SOCKET, RAWIP_SOCKET__NODE_BIND, "node_bind" },
    { SECCLASS_NODE, NODE__TCP_RECV, "tcp_recv" },
    { SECCLASS_NODE, NODE__TCP_SEND, "tcp_send" },
    { SECCLASS_NODE, NODE__UDP_RECV, "udp_recv" },
@@ -46,9 +49,6 @@
    { SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO, "connectto" },
    { SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN, "newconn" },
    { SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM, "acceptfrom" },
-   { SECCLASS_TCP_SOCKET, TCP_SOCKET__NODE_BIND, "node_bind" },
-   { SECCLASS_UDP_SOCKET, UDP_SOCKET__NODE_BIND, "node_bind" },
-   { SECCLASS_RAWIP_SOCKET, RAWIP_SOCKET__NODE_BIND, "node_bind" },
    { SECCLASS_PROCESS, PROCESS__FORK, "fork" },
    { SECCLASS_PROCESS, PROCESS__TRANSITION, "transition" },
    { SECCLASS_PROCESS, PROCESS__SIGCHLD, "sigchld" },
@@ -121,6 +121,92 @@
    { SECCLASS_PASSWD, PASSWD__PASSWD, "passwd" },
    { SECCLASS_PASSWD, PASSWD__CHFN, "chfn" },
    { SECCLASS_PASSWD, PASSWD__CHSH, "chsh" },
+   { SECCLASS_PASSWD, PASSWD__ROOTOK, "rootok" },
+   { SECCLASS_DRAWABLE, DRAWABLE__CREATE, "create" },
+   { SECCLASS_DRAWABLE, DRAWABLE__DESTROY, "destroy" },
+   { SECCLASS_DRAWABLE, DRAWABLE__DRAW, "draw" },
+   { SECCLASS_DRAWABLE, DRAWABLE__COPY, "copy" },
+   { SECCLASS_DRAWABLE, DRAWABLE__GETATTR, "getattr" },
+   { SECCLASS_GC, GC__CREATE, "create" },
+   { SECCLASS_GC, GC__FREE, "free" },
+   { SECCLASS_GC, GC__GETATTR, "getattr" },
+   { SECCLASS_GC, GC__SETATTR, "setattr" },
+   { SECCLASS_WINDOW, WINDOW__ADDCHILD, "addchild" },
+   { SECCLASS_WINDOW, WINDOW__CREATE, "create" },
+   { SECCLASS_WINDOW, WINDOW__DESTROY, "destroy" },
+   { SECCLASS_WINDOW, WINDOW__MAP, "map" },
+   { SECCLASS_WINDOW, WINDOW__UNMAP, "unmap" },
+   { SECCLASS_WINDOW, WINDOW__CHSTACK, "chstack" },
+   { SECCLASS_WINDOW, WINDOW__CHPROPLIST, "chproplist" },
+   { SECCLASS_WINDOW, WINDOW__CHPROP, "chprop" },
+   { SECCLASS_WINDOW, WINDOW__LISTPROP, "listprop" },
+   { SECCLASS_WINDOW, WINDOW__GETATTR, "getattr" },
+   { SECCLASS_WINDOW, WINDOW__SETATTR, "setattr" },
+   { SECCLASS_WINDOW, WINDOW__SETFOCUS, "setfocus" },
+   { SECCLASS_WINDOW, WINDOW__MOVE, "move" },
+   { SECCLASS_WINDOW, WINDOW__CHSELECTION, "chselection" },
+   { SECCLASS_WINDOW, WINDOW__CHPARENT, "chparent" },
+   { SECCLASS_WINDOW, WINDOW__CTRLLIFE, "ctrllife" },
+   { SECCLASS_WINDOW, WINDOW__ENUMERATE, "enumerate" },
+   { SECCLASS_WINDOW, WINDOW__TRANSPARENT, "transparent" },
+   { SECCLASS_WINDOW, WINDOW__MOUSEMOTION, "mousemotion" },
+   { SECCLASS_WINDOW, WINDOW__CLIENTCOMEVENT, "clientcomevent" },
+   { SECCLASS_WINDOW, WINDOW__INPUTEVENT, "inputevent" },
+   { SECCLASS_WINDOW, WINDOW__DRAWEVENT, "drawevent" },
+   { SECCLASS_WINDOW, WINDOW__WINDOWCHANGEEVENT, "windowchangeevent" },
+   { SECCLASS_WINDOW, WINDOW__WINDOWCHANGEREQUEST, "windowchangerequest" },
+   { SECCLASS_WINDOW, WINDOW__SERVERCHANGEEVENT, "serverchangeevent" },
+   { SECCLASS_WINDOW, WINDOW__EXTENSIONEVENT, "extensionevent" },
+   { SECCLASS_FONT, FONT__LOAD, "load" },
+   { SECCLASS_FONT, FONT__FREE, "free" },
+   { SECCLASS_FONT, FONT__GETATTR, "getattr" },
+   { SECCLASS_FONT, FONT__USE, "use" },
+   { SECCLASS_COLORMAP, COLORMAP__CREATE, "create" },
+   { SECCLASS_COLORMAP, COLORMAP__FREE, "free" },
+   { SECCLASS_COLORMAP, COLORMAP__INSTALL, "install" },
+   { SECCLASS_COLORMAP, COLORMAP__UNINSTALL, "uninstall" },
+   { SECCLASS_COLORMAP, COLORMAP__LIST, "list" },
+   { SECCLASS_COLORMAP, COLORMAP__READ, "read" },
+   { SECCLASS_COLORMAP, COLORMAP__STORE, "store" },
+   { SECCLASS_COLORMAP, COLORMAP__GETATTR, "getattr" },
+   { SECCLASS_COLORMAP, COLORMAP__SETATTR, "setattr" },
+   { SECCLASS_PROPERTY, PROPERTY__CREATE, "create" },
+   { SECCLASS_PROPERTY, PROPERTY__FREE, "free" },
+   { SECCLASS_PROPERTY, PROPERTY__READ, "read" },
+   { SECCLASS_PROPERTY, PROPERTY__WRITE, "write" },
+   { SECCLASS_CURSOR, CURSOR__CREATE, "create" },
+   { SECCLASS_CURSOR, CURSOR__CREATEGLYPH, "createglyph" },
+   { SECCLASS_CURSOR, CURSOR__FREE, "free" },
+   { SECCLASS_CURSOR, CURSOR__ASSIGN, "assign" },
+   { SECCLASS_CURSOR, CURSOR__SETATTR, "setattr" },
+   { SECCLASS_XCLIENT, XCLIENT__KILL, "kill" },
+   { SECCLASS_XINPUT, XINPUT__LOOKUP, "lookup" },
+   { SECCLASS_XINPUT, XINPUT__GETATTR, "getattr" },
+   { SECCLASS_XINPUT, XINPUT__SETATTR, "setattr" },
+   { SECCLASS_XINPUT, XINPUT__SETFOCUS, "setfocus" },
+   { SECCLASS_XINPUT, XINPUT__WARPPOINTER, "warppointer" },
+   { SECCLASS_XINPUT, XINPUT__ACTIVEGRAB, "activegrab" },
+   { SECCLASS_XINPUT, XINPUT__PASSIVEGRAB, "passivegrab" },
+   { SECCLASS_XINPUT, XINPUT__UNGRAB, "ungrab" },
+   { SECCLASS_XINPUT, XINPUT__BELL, "bell" },
+   { SECCLASS_XINPUT, XINPUT__MOUSEMOTION, "mousemotion" },
+   { SECCLASS_XINPUT, XINPUT__RELABELINPUT, "relabelinput" },
+   { SECCLASS_XSERVER, XSERVER__SCREENSAVER, "screensaver" },
+   { SECCLASS_XSERVER, XSERVER__GETHOSTLIST, "gethostlist" },
+   { SECCLASS_XSERVER, XSERVER__SETHOSTLIST, "sethostlist" },
+   { SECCLASS_XSERVER, XSERVER__GETFONTPATH, "getfontpath" },
+   { SECCLASS_XSERVER, XSERVER__SETFONTPATH, "setfontpath" },
+   { SECCLASS_XSERVER, XSERVER__GETATTR, "getattr" },
+   { SECCLASS_XSERVER, XSERVER__GRAB, "grab" },
+   { SECCLASS_XSERVER, XSERVER__UNGRAB, "ungrab" },
+   { SECCLASS_XEXTENSION, XEXTENSION__QUERY, "query" },
+   { SECCLASS_XEXTENSION, XEXTENSION__USE, "use" },
+   { SECCLASS_PAX, PAX__PAGEEXEC, "pageexec" },
+   { SECCLASS_PAX, PAX__EMUTRAMP, "emutramp" },
+   { SECCLASS_PAX, PAX__MPROTECT, "mprotect" },
+   { SECCLASS_PAX, PAX__RANDMMAP, "randmmap" },
+   { SECCLASS_PAX, PAX__RANDEXEC, "randexec" },
+   { SECCLASS_PAX, PAX__SEGMEXEC, "segmexec" },
 };
 
 
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.10
diff -u -r1.10 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	10 May 2004 13:01:08 -0000	1.10
+++ linux-2.6/security/selinux/include/av_permissions.h	26 May 2004 15:36:03 -0000
@@ -63,23 +63,23 @@
 #define FILESYSTEM__QUOTAMOD                      0x00000100UL
 #define FILESYSTEM__QUOTAGET                      0x00000200UL
 
-#define DIR__EXECUTE                              0x00002000UL
-#define DIR__UNLINK                               0x00000400UL
+#define DIR__IOCTL                                0x00000001UL
+#define DIR__READ                                 0x00000002UL
+#define DIR__WRITE                                0x00000004UL
+#define DIR__CREATE                               0x00000008UL
+#define DIR__GETATTR                              0x00000010UL
 #define DIR__SETATTR                              0x00000020UL
-#define DIR__QUOTAON                              0x00008000UL
+#define DIR__LOCK                                 0x00000040UL
 #define DIR__RELABELFROM                          0x00000080UL
-#define DIR__LINK                                 0x00000800UL
-#define DIR__WRITE                                0x00000004UL
-#define DIR__IOCTL                                0x00000001UL
 #define DIR__RELABELTO                            0x00000100UL
-#define DIR__READ                                 0x00000002UL
-#define DIR__RENAME                               0x00001000UL
 #define DIR__APPEND                               0x00000200UL
-#define DIR__LOCK                                 0x00000040UL
+#define DIR__UNLINK                               0x00000400UL
+#define DIR__LINK                                 0x00000800UL
+#define DIR__RENAME                               0x00001000UL
+#define DIR__EXECUTE                              0x00002000UL
 #define DIR__SWAPON                               0x00004000UL
-#define DIR__GETATTR                              0x00000010UL
+#define DIR__QUOTAON                              0x00008000UL
 #define DIR__MOUNTON                              0x00010000UL
-#define DIR__CREATE                               0x00000008UL
 
 #define DIR__ADD_NAME                             0x00020000UL
 #define DIR__REMOVE_NAME                          0x00040000UL
@@ -87,216 +87,218 @@
 #define DIR__SEARCH                               0x00100000UL
 #define DIR__RMDIR                                0x00200000UL
 
-#define FILE__EXECUTE                             0x00002000UL
-#define FILE__UNLINK                              0x00000400UL
+#define FILE__IOCTL                               0x00000001UL
+#define FILE__READ                                0x00000002UL
+#define FILE__WRITE                               0x00000004UL
+#define FILE__CREATE                              0x00000008UL
+#define FILE__GETATTR                             0x00000010UL
 #define FILE__SETATTR                             0x00000020UL
-#define FILE__QUOTAON                             0x00008000UL
+#define FILE__LOCK                                0x00000040UL
 #define FILE__RELABELFROM                         0x00000080UL
-#define FILE__LINK                                0x00000800UL
-#define FILE__WRITE                               0x00000004UL
-#define FILE__IOCTL                               0x00000001UL
 #define FILE__RELABELTO                           0x00000100UL
-#define FILE__READ                                0x00000002UL
-#define FILE__RENAME                              0x00001000UL
 #define FILE__APPEND                              0x00000200UL
-#define FILE__LOCK                                0x00000040UL
+#define FILE__UNLINK                              0x00000400UL
+#define FILE__LINK                                0x00000800UL
+#define FILE__RENAME                              0x00001000UL
+#define FILE__EXECUTE                             0x00002000UL
 #define FILE__SWAPON                              0x00004000UL
-#define FILE__GETATTR                             0x00000010UL
+#define FILE__QUOTAON                             0x00008000UL
 #define FILE__MOUNTON                             0x00010000UL
-#define FILE__CREATE                              0x00000008UL
 
 #define FILE__EXECUTE_NO_TRANS                    0x00020000UL
 #define FILE__ENTRYPOINT                          0x00040000UL
 
-#define LNK_FILE__EXECUTE                         0x00002000UL
-#define LNK_FILE__UNLINK                          0x00000400UL
+#define LNK_FILE__IOCTL                           0x00000001UL
+#define LNK_FILE__READ                            0x00000002UL
+#define LNK_FILE__WRITE                           0x00000004UL
+#define LNK_FILE__CREATE                          0x00000008UL
+#define LNK_FILE__GETATTR                         0x00000010UL
 #define LNK_FILE__SETATTR                         0x00000020UL
-#define LNK_FILE__QUOTAON                         0x00008000UL
+#define LNK_FILE__LOCK                            0x00000040UL
 #define LNK_FILE__RELABELFROM                     0x00000080UL
-#define LNK_FILE__LINK                            0x00000800UL
-#define LNK_FILE__WRITE                           0x00000004UL
-#define LNK_FILE__IOCTL                           0x00000001UL
 #define LNK_FILE__RELABELTO                       0x00000100UL
-#define LNK_FILE__READ                            0x00000002UL
-#define LNK_FILE__RENAME                          0x00001000UL
 #define LNK_FILE__APPEND                          0x00000200UL
-#define LNK_FILE__LOCK                            0x00000040UL
+#define LNK_FILE__UNLINK                          0x00000400UL
+#define LNK_FILE__LINK                            0x00000800UL
+#define LNK_FILE__RENAME                          0x00001000UL
+#define LNK_FILE__EXECUTE                         0x00002000UL
 #define LNK_FILE__SWAPON                          0x00004000UL
-#define LNK_FILE__GETATTR                         0x00000010UL
+#define LNK_FILE__QUOTAON                         0x00008000UL
 #define LNK_FILE__MOUNTON                         0x00010000UL
-#define LNK_FILE__CREATE                          0x00000008UL
 
-#define CHR_FILE__EXECUTE                         0x00002000UL
-#define CHR_FILE__UNLINK                          0x00000400UL
+#define CHR_FILE__IOCTL                           0x00000001UL
+#define CHR_FILE__READ                            0x00000002UL
+#define CHR_FILE__WRITE                           0x00000004UL
+#define CHR_FILE__CREATE                          0x00000008UL
+#define CHR_FILE__GETATTR                         0x00000010UL
 #define CHR_FILE__SETATTR                         0x00000020UL
-#define CHR_FILE__QUOTAON                         0x00008000UL
+#define CHR_FILE__LOCK                            0x00000040UL
 #define CHR_FILE__RELABELFROM                     0x00000080UL
-#define CHR_FILE__LINK                            0x00000800UL
-#define CHR_FILE__WRITE                           0x00000004UL
-#define CHR_FILE__IOCTL                           0x00000001UL
 #define CHR_FILE__RELABELTO                       0x00000100UL
-#define CHR_FILE__READ                            0x00000002UL
-#define CHR_FILE__RENAME                          0x00001000UL
 #define CHR_FILE__APPEND                          0x00000200UL
-#define CHR_FILE__LOCK                            0x00000040UL
+#define CHR_FILE__UNLINK                          0x00000400UL
+#define CHR_FILE__LINK                            0x00000800UL
+#define CHR_FILE__RENAME                          0x00001000UL
+#define CHR_FILE__EXECUTE                         0x00002000UL
 #define CHR_FILE__SWAPON                          0x00004000UL
-#define CHR_FILE__GETATTR                         0x00000010UL
+#define CHR_FILE__QUOTAON                         0x00008000UL
 #define CHR_FILE__MOUNTON                         0x00010000UL
-#define CHR_FILE__CREATE                          0x00000008UL
 
-#define BLK_FILE__EXECUTE                         0x00002000UL
-#define BLK_FILE__UNLINK                          0x00000400UL
+#define BLK_FILE__IOCTL                           0x00000001UL
+#define BLK_FILE__READ                            0x00000002UL
+#define BLK_FILE__WRITE                           0x00000004UL
+#define BLK_FILE__CREATE                          0x00000008UL
+#define BLK_FILE__GETATTR                         0x00000010UL
 #define BLK_FILE__SETATTR                         0x00000020UL
-#define BLK_FILE__QUOTAON                         0x00008000UL
+#define BLK_FILE__LOCK                            0x00000040UL
 #define BLK_FILE__RELABELFROM                     0x00000080UL
-#define BLK_FILE__LINK                            0x00000800UL
-#define BLK_FILE__WRITE                           0x00000004UL
-#define BLK_FILE__IOCTL                           0x00000001UL
 #define BLK_FILE__RELABELTO                       0x00000100UL
-#define BLK_FILE__READ                            0x00000002UL
-#define BLK_FILE__RENAME                          0x00001000UL
 #define BLK_FILE__APPEND                          0x00000200UL
-#define BLK_FILE__LOCK                            0x00000040UL
+#define BLK_FILE__UNLINK                          0x00000400UL
+#define BLK_FILE__LINK                            0x00000800UL
+#define BLK_FILE__RENAME                          0x00001000UL
+#define BLK_FILE__EXECUTE                         0x00002000UL
 #define BLK_FILE__SWAPON                          0x00004000UL
-#define BLK_FILE__GETATTR                         0x00000010UL
+#define BLK_FILE__QUOTAON                         0x00008000UL
 #define BLK_FILE__MOUNTON                         0x00010000UL
-#define BLK_FILE__CREATE                          0x00000008UL
 
-#define SOCK_FILE__EXECUTE                        0x00002000UL
-#define SOCK_FILE__UNLINK                         0x00000400UL
+#define SOCK_FILE__IOCTL                          0x00000001UL
+#define SOCK_FILE__READ                           0x00000002UL
+#define SOCK_FILE__WRITE                          0x00000004UL
+#define SOCK_FILE__CREATE                         0x00000008UL
+#define SOCK_FILE__GETATTR                        0x00000010UL
 #define SOCK_FILE__SETATTR                        0x00000020UL
-#define SOCK_FILE__QUOTAON                        0x00008000UL
+#define SOCK_FILE__LOCK                           0x00000040UL
 #define SOCK_FILE__RELABELFROM                    0x00000080UL
-#define SOCK_FILE__LINK                           0x00000800UL
-#define SOCK_FILE__WRITE                          0x00000004UL
-#define SOCK_FILE__IOCTL                          0x00000001UL
 #define SOCK_FILE__RELABELTO                      0x00000100UL
-#define SOCK_FILE__READ                           0x00000002UL
-#define SOCK_FILE__RENAME                         0x00001000UL
 #define SOCK_FILE__APPEND                         0x00000200UL
-#define SOCK_FILE__LOCK                           0x00000040UL
+#define SOCK_FILE__UNLINK                         0x00000400UL
+#define SOCK_FILE__LINK                           0x00000800UL
+#define SOCK_FILE__RENAME                         0x00001000UL
+#define SOCK_FILE__EXECUTE                        0x00002000UL
 #define SOCK_FILE__SWAPON                         0x00004000UL
-#define SOCK_FILE__GETATTR                        0x00000010UL
+#define SOCK_FILE__QUOTAON                        0x00008000UL
 #define SOCK_FILE__MOUNTON                        0x00010000UL
-#define SOCK_FILE__CREATE                         0x00000008UL
 
-#define FIFO_FILE__EXECUTE                        0x00002000UL
-#define FIFO_FILE__UNLINK                         0x00000400UL
+#define FIFO_FILE__IOCTL                          0x00000001UL
+#define FIFO_FILE__READ                           0x00000002UL
+#define FIFO_FILE__WRITE                          0x00000004UL
+#define FIFO_FILE__CREATE                         0x00000008UL
+#define FIFO_FILE__GETATTR                        0x00000010UL
 #define FIFO_FILE__SETATTR                        0x00000020UL
-#define FIFO_FILE__QUOTAON                        0x00008000UL
+#define FIFO_FILE__LOCK                           0x00000040UL
 #define FIFO_FILE__RELABELFROM                    0x00000080UL
-#define FIFO_FILE__LINK                           0x00000800UL
-#define FIFO_FILE__WRITE                          0x00000004UL
-#define FIFO_FILE__IOCTL                          0x00000001UL
 #define FIFO_FILE__RELABELTO                      0x00000100UL
-#define FIFO_FILE__READ                           0x00000002UL
-#define FIFO_FILE__RENAME                         0x00001000UL
 #define FIFO_FILE__APPEND                         0x00000200UL
-#define FIFO_FILE__LOCK                           0x00000040UL
+#define FIFO_FILE__UNLINK                         0x00000400UL
+#define FIFO_FILE__LINK                           0x00000800UL
+#define FIFO_FILE__RENAME                         0x00001000UL
+#define FIFO_FILE__EXECUTE                        0x00002000UL
 #define FIFO_FILE__SWAPON                         0x00004000UL
-#define FIFO_FILE__GETATTR                        0x00000010UL
+#define FIFO_FILE__QUOTAON                        0x00008000UL
 #define FIFO_FILE__MOUNTON                        0x00010000UL
-#define FIFO_FILE__CREATE                         0x00000008UL
 
 #define FD__USE                                   0x00000001UL
 
-#define SOCKET__RELABELTO                         0x00000100UL
-#define SOCKET__RECV_MSG                          0x00080000UL
+#define SOCKET__IOCTL                             0x00000001UL
+#define SOCKET__READ                              0x00000002UL
+#define SOCKET__WRITE                             0x00000004UL
+#define SOCKET__CREATE                            0x00000008UL
+#define SOCKET__GETATTR                           0x00000010UL
+#define SOCKET__SETATTR                           0x00000020UL
+#define SOCKET__LOCK                              0x00000040UL
 #define SOCKET__RELABELFROM                       0x00000080UL
-#define SOCKET__SETOPT                            0x00008000UL
+#define SOCKET__RELABELTO                         0x00000100UL
 #define SOCKET__APPEND                            0x00000200UL
-#define SOCKET__SETATTR                           0x00000020UL
-#define SOCKET__SENDTO                            0x00040000UL
-#define SOCKET__GETOPT                            0x00004000UL
-#define SOCKET__READ                              0x00000002UL
-#define SOCKET__SHUTDOWN                          0x00010000UL
-#define SOCKET__LISTEN                            0x00001000UL
 #define SOCKET__BIND                              0x00000400UL
-#define SOCKET__WRITE                             0x00000004UL
-#define SOCKET__ACCEPT                            0x00002000UL
 #define SOCKET__CONNECT                           0x00000800UL
-#define SOCKET__LOCK                              0x00000040UL
-#define SOCKET__IOCTL                             0x00000001UL
-#define SOCKET__CREATE                            0x00000008UL
-#define SOCKET__NAME_BIND                         0x00200000UL
-#define SOCKET__SEND_MSG                          0x00100000UL
+#define SOCKET__LISTEN                            0x00001000UL
+#define SOCKET__ACCEPT                            0x00002000UL
+#define SOCKET__GETOPT                            0x00004000UL
+#define SOCKET__SETOPT                            0x00008000UL
+#define SOCKET__SHUTDOWN                          0x00010000UL
 #define SOCKET__RECVFROM                          0x00020000UL
-#define SOCKET__GETATTR                           0x00000010UL
+#define SOCKET__SENDTO                            0x00040000UL
+#define SOCKET__RECV_MSG                          0x00080000UL
+#define SOCKET__SEND_MSG                          0x00100000UL
+#define SOCKET__NAME_BIND                         0x00200000UL
 
-#define TCP_SOCKET__RELABELTO                     0x00000100UL
-#define TCP_SOCKET__RECV_MSG                      0x00080000UL
+#define TCP_SOCKET__IOCTL                         0x00000001UL
+#define TCP_SOCKET__READ                          0x00000002UL
+#define TCP_SOCKET__WRITE                         0x00000004UL
+#define TCP_SOCKET__CREATE                        0x00000008UL
+#define TCP_SOCKET__GETATTR                       0x00000010UL
+#define TCP_SOCKET__SETATTR                       0x00000020UL
+#define TCP_SOCKET__LOCK                          0x00000040UL
 #define TCP_SOCKET__RELABELFROM                   0x00000080UL
-#define TCP_SOCKET__SETOPT                        0x00008000UL
+#define TCP_SOCKET__RELABELTO                     0x00000100UL
 #define TCP_SOCKET__APPEND                        0x00000200UL
-#define TCP_SOCKET__SETATTR                       0x00000020UL
-#define TCP_SOCKET__SENDTO                        0x00040000UL
-#define TCP_SOCKET__GETOPT                        0x00004000UL
-#define TCP_SOCKET__READ                          0x00000002UL
-#define TCP_SOCKET__SHUTDOWN                      0x00010000UL
-#define TCP_SOCKET__LISTEN                        0x00001000UL
 #define TCP_SOCKET__BIND                          0x00000400UL
-#define TCP_SOCKET__WRITE                         0x00000004UL
-#define TCP_SOCKET__ACCEPT                        0x00002000UL
 #define TCP_SOCKET__CONNECT                       0x00000800UL
-#define TCP_SOCKET__LOCK                          0x00000040UL
-#define TCP_SOCKET__IOCTL                         0x00000001UL
-#define TCP_SOCKET__CREATE                        0x00000008UL
-#define TCP_SOCKET__NAME_BIND                     0x00200000UL
-#define TCP_SOCKET__SEND_MSG                      0x00100000UL
+#define TCP_SOCKET__LISTEN                        0x00001000UL
+#define TCP_SOCKET__ACCEPT                        0x00002000UL
+#define TCP_SOCKET__GETOPT                        0x00004000UL
+#define TCP_SOCKET__SETOPT                        0x00008000UL
+#define TCP_SOCKET__SHUTDOWN                      0x00010000UL
 #define TCP_SOCKET__RECVFROM                      0x00020000UL
-#define TCP_SOCKET__GETATTR                       0x00000010UL
+#define TCP_SOCKET__SENDTO                        0x00040000UL
+#define TCP_SOCKET__RECV_MSG                      0x00080000UL
+#define TCP_SOCKET__SEND_MSG                      0x00100000UL
+#define TCP_SOCKET__NAME_BIND                     0x00200000UL
 
 #define TCP_SOCKET__CONNECTTO                     0x00400000UL
 #define TCP_SOCKET__NEWCONN                       0x00800000UL
 #define TCP_SOCKET__ACCEPTFROM                    0x01000000UL
 #define TCP_SOCKET__NODE_BIND                     0x02000000UL
 
-#define UDP_SOCKET__RELABELTO                     0x00000100UL
-#define UDP_SOCKET__RECV_MSG                      0x00080000UL
+#define UDP_SOCKET__IOCTL                         0x00000001UL
+#define UDP_SOCKET__READ                          0x00000002UL
+#define UDP_SOCKET__WRITE                         0x00000004UL
+#define UDP_SOCKET__CREATE                        0x00000008UL
+#define UDP_SOCKET__GETATTR                       0x00000010UL
+#define UDP_SOCKET__SETATTR                       0x00000020UL
+#define UDP_SOCKET__LOCK                          0x00000040UL
 #define UDP_SOCKET__RELABELFROM                   0x00000080UL
-#define UDP_SOCKET__SETOPT                        0x00008000UL
+#define UDP_SOCKET__RELABELTO                     0x00000100UL
 #define UDP_SOCKET__APPEND                        0x00000200UL
-#define UDP_SOCKET__SETATTR                       0x00000020UL
-#define UDP_SOCKET__SENDTO                        0x00040000UL
-#define UDP_SOCKET__GETOPT                        0x00004000UL
-#define UDP_SOCKET__READ                          0x00000002UL
-#define UDP_SOCKET__SHUTDOWN                      0x00010000UL
-#define UDP_SOCKET__LISTEN                        0x00001000UL
 #define UDP_SOCKET__BIND                          0x00000400UL
-#define UDP_SOCKET__WRITE                         0x00000004UL
-#define UDP_SOCKET__ACCEPT                        0x00002000UL
 #define UDP_SOCKET__CONNECT                       0x00000800UL
-#define UDP_SOCKET__LOCK                          0x00000040UL
-#define UDP_SOCKET__IOCTL                         0x00000001UL
-#define UDP_SOCKET__CREATE                        0x00000008UL
-#define UDP_SOCKET__NAME_BIND                     0x00200000UL
-#define UDP_SOCKET__SEND_MSG                      0x00100000UL
+#define UDP_SOCKET__LISTEN                        0x00001000UL
+#define UDP_SOCKET__ACCEPT                        0x00002000UL
+#define UDP_SOCKET__GETOPT                        0x00004000UL
+#define UDP_SOCKET__SETOPT                        0x00008000UL
+#define UDP_SOCKET__SHUTDOWN                      0x00010000UL
 #define UDP_SOCKET__RECVFROM                      0x00020000UL
-#define UDP_SOCKET__GETATTR                       0x00000010UL
+#define UDP_SOCKET__SENDTO                        0x00040000UL
+#define UDP_SOCKET__RECV_MSG                      0x00080000UL
+#define UDP_SOCKET__SEND_MSG                      0x00100000UL
+#define UDP_SOCKET__NAME_BIND                     0x00200000UL
+
 #define UDP_SOCKET__NODE_BIND                     0x00400000UL
 
-#define RAWIP_SOCKET__RELABELTO                   0x00000100UL
-#define RAWIP_SOCKET__RECV_MSG                    0x00080000UL
+#define RAWIP_SOCKET__IOCTL                       0x00000001UL
+#define RAWIP_SOCKET__READ                        0x00000002UL
+#define RAWIP_SOCKET__WRITE                       0x00000004UL
+#define RAWIP_SOCKET__CREATE                      0x00000008UL
+#define RAWIP_SOCKET__GETATTR                     0x00000010UL
+#define RAWIP_SOCKET__SETATTR                     0x00000020UL
+#define RAWIP_SOCKET__LOCK                        0x00000040UL
 #define RAWIP_SOCKET__RELABELFROM                 0x00000080UL
-#define RAWIP_SOCKET__SETOPT                      0x00008000UL
+#define RAWIP_SOCKET__RELABELTO                   0x00000100UL
 #define RAWIP_SOCKET__APPEND                      0x00000200UL
-#define RAWIP_SOCKET__SETATTR                     0x00000020UL
-#define RAWIP_SOCKET__SENDTO                      0x00040000UL
-#define RAWIP_SOCKET__GETOPT                      0x00004000UL
-#define RAWIP_SOCKET__READ                        0x00000002UL
-#define RAWIP_SOCKET__SHUTDOWN                    0x00010000UL
-#define RAWIP_SOCKET__LISTEN                      0x00001000UL
 #define RAWIP_SOCKET__BIND                        0x00000400UL
-#define RAWIP_SOCKET__WRITE                       0x00000004UL
-#define RAWIP_SOCKET__ACCEPT                      0x00002000UL
 #define RAWIP_SOCKET__CONNECT                     0x00000800UL
-#define RAWIP_SOCKET__LOCK                        0x00000040UL
-#define RAWIP_SOCKET__IOCTL                       0x00000001UL
-#define RAWIP_SOCKET__CREATE                      0x00000008UL
-#define RAWIP_SOCKET__NAME_BIND                   0x00200000UL
-#define RAWIP_SOCKET__SEND_MSG                    0x00100000UL
+#define RAWIP_SOCKET__LISTEN                      0x00001000UL
+#define RAWIP_SOCKET__ACCEPT                      0x00002000UL
+#define RAWIP_SOCKET__GETOPT                      0x00004000UL
+#define RAWIP_SOCKET__SETOPT                      0x00008000UL
+#define RAWIP_SOCKET__SHUTDOWN                    0x00010000UL
 #define RAWIP_SOCKET__RECVFROM                    0x00020000UL
-#define RAWIP_SOCKET__GETATTR                     0x00000010UL
+#define RAWIP_SOCKET__SENDTO                      0x00040000UL
+#define RAWIP_SOCKET__RECV_MSG                    0x00080000UL
+#define RAWIP_SOCKET__SEND_MSG                    0x00100000UL
+#define RAWIP_SOCKET__NAME_BIND                   0x00200000UL
+
 #define RAWIP_SOCKET__NODE_BIND                   0x00400000UL
 
 #define NODE__TCP_RECV                            0x00000001UL
@@ -314,124 +316,124 @@
 #define NETIF__RAWIP_RECV                         0x00000010UL
 #define NETIF__RAWIP_SEND                         0x00000020UL
 
-#define NETLINK_SOCKET__RELABELTO                 0x00000100UL
-#define NETLINK_SOCKET__RECV_MSG                  0x00080000UL
+#define NETLINK_SOCKET__IOCTL                     0x00000001UL
+#define NETLINK_SOCKET__READ                      0x00000002UL
+#define NETLINK_SOCKET__WRITE                     0x00000004UL
+#define NETLINK_SOCKET__CREATE                    0x00000008UL
+#define NETLINK_SOCKET__GETATTR                   0x00000010UL
+#define NETLINK_SOCKET__SETATTR                   0x00000020UL
+#define NETLINK_SOCKET__LOCK                      0x00000040UL
 #define NETLINK_SOCKET__RELABELFROM               0x00000080UL
-#define NETLINK_SOCKET__SETOPT                    0x00008000UL
+#define NETLINK_SOCKET__RELABELTO                 0x00000100UL
 #define NETLINK_SOCKET__APPEND                    0x00000200UL
-#define NETLINK_SOCKET__SETATTR                   0x00000020UL
-#define NETLINK_SOCKET__SENDTO                    0x00040000UL
-#define NETLINK_SOCKET__GETOPT                    0x00004000UL
-#define NETLINK_SOCKET__READ                      0x00000002UL
-#define NETLINK_SOCKET__SHUTDOWN                  0x00010000UL
-#define NETLINK_SOCKET__LISTEN                    0x00001000UL
 #define NETLINK_SOCKET__BIND                      0x00000400UL
-#define NETLINK_SOCKET__WRITE                     0x00000004UL
-#define NETLINK_SOCKET__ACCEPT                    0x00002000UL
 #define NETLINK_SOCKET__CONNECT                   0x00000800UL
-#define NETLINK_SOCKET__LOCK                      0x00000040UL
-#define NETLINK_SOCKET__IOCTL                     0x00000001UL
-#define NETLINK_SOCKET__CREATE                    0x00000008UL
-#define NETLINK_SOCKET__NAME_BIND                 0x00200000UL
-#define NETLINK_SOCKET__SEND_MSG                  0x00100000UL
+#define NETLINK_SOCKET__LISTEN                    0x00001000UL
+#define NETLINK_SOCKET__ACCEPT                    0x00002000UL
+#define NETLINK_SOCKET__GETOPT                    0x00004000UL
+#define NETLINK_SOCKET__SETOPT                    0x00008000UL
+#define NETLINK_SOCKET__SHUTDOWN                  0x00010000UL
 #define NETLINK_SOCKET__RECVFROM                  0x00020000UL
-#define NETLINK_SOCKET__GETATTR                   0x00000010UL
+#define NETLINK_SOCKET__SENDTO                    0x00040000UL
+#define NETLINK_SOCKET__RECV_MSG                  0x00080000UL
+#define NETLINK_SOCKET__SEND_MSG                  0x00100000UL
+#define NETLINK_SOCKET__NAME_BIND                 0x00200000UL
 
-#define PACKET_SOCKET__RELABELTO                  0x00000100UL
-#define PACKET_SOCKET__RECV_MSG                   0x00080000UL
+#define PACKET_SOCKET__IOCTL                      0x00000001UL
+#define PACKET_SOCKET__READ                       0x00000002UL
+#define PACKET_SOCKET__WRITE                      0x00000004UL
+#define PACKET_SOCKET__CREATE                     0x00000008UL
+#define PACKET_SOCKET__GETATTR                    0x00000010UL
+#define PACKET_SOCKET__SETATTR                    0x00000020UL
+#define PACKET_SOCKET__LOCK                       0x00000040UL
 #define PACKET_SOCKET__RELABELFROM                0x00000080UL
-#define PACKET_SOCKET__SETOPT                     0x00008000UL
+#define PACKET_SOCKET__RELABELTO                  0x00000100UL
 #define PACKET_SOCKET__APPEND                     0x00000200UL
-#define PACKET_SOCKET__SETATTR                    0x00000020UL
-#define PACKET_SOCKET__SENDTO                     0x00040000UL
-#define PACKET_SOCKET__GETOPT                     0x00004000UL
-#define PACKET_SOCKET__READ                       0x00000002UL
-#define PACKET_SOCKET__SHUTDOWN                   0x00010000UL
-#define PACKET_SOCKET__LISTEN                     0x00001000UL
 #define PACKET_SOCKET__BIND                       0x00000400UL
-#define PACKET_SOCKET__WRITE                      0x00000004UL
-#define PACKET_SOCKET__ACCEPT                     0x00002000UL
 #define PACKET_SOCKET__CONNECT                    0x00000800UL
-#define PACKET_SOCKET__LOCK                       0x00000040UL
-#define PACKET_SOCKET__IOCTL                      0x00000001UL
-#define PACKET_SOCKET__CREATE                     0x00000008UL
-#define PACKET_SOCKET__NAME_BIND                  0x00200000UL
-#define PACKET_SOCKET__SEND_MSG                   0x00100000UL
+#define PACKET_SOCKET__LISTEN                     0x00001000UL
+#define PACKET_SOCKET__ACCEPT                     0x00002000UL
+#define PACKET_SOCKET__GETOPT                     0x00004000UL
+#define PACKET_SOCKET__SETOPT                     0x00008000UL
+#define PACKET_SOCKET__SHUTDOWN                   0x00010000UL
 #define PACKET_SOCKET__RECVFROM                   0x00020000UL
-#define PACKET_SOCKET__GETATTR                    0x00000010UL
+#define PACKET_SOCKET__SENDTO                     0x00040000UL
+#define PACKET_SOCKET__RECV_MSG                   0x00080000UL
+#define PACKET_SOCKET__SEND_MSG                   0x00100000UL
+#define PACKET_SOCKET__NAME_BIND                  0x00200000UL
 
-#define KEY_SOCKET__RELABELTO                     0x00000100UL
-#define KEY_SOCKET__RECV_MSG                      0x00080000UL
+#define KEY_SOCKET__IOCTL                         0x00000001UL
+#define KEY_SOCKET__READ                          0x00000002UL
+#define KEY_SOCKET__WRITE                         0x00000004UL
+#define KEY_SOCKET__CREATE                        0x00000008UL
+#define KEY_SOCKET__GETATTR                       0x00000010UL
+#define KEY_SOCKET__SETATTR                       0x00000020UL
+#define KEY_SOCKET__LOCK                          0x00000040UL
 #define KEY_SOCKET__RELABELFROM                   0x00000080UL
-#define KEY_SOCKET__SETOPT                        0x00008000UL
+#define KEY_SOCKET__RELABELTO                     0x00000100UL
 #define KEY_SOCKET__APPEND                        0x00000200UL
-#define KEY_SOCKET__SETATTR                       0x00000020UL
-#define KEY_SOCKET__SENDTO                        0x00040000UL
-#define KEY_SOCKET__GETOPT                        0x00004000UL
-#define KEY_SOCKET__READ                          0x00000002UL
-#define KEY_SOCKET__SHUTDOWN                      0x00010000UL
-#define KEY_SOCKET__LISTEN                        0x00001000UL
 #define KEY_SOCKET__BIND                          0x00000400UL
-#define KEY_SOCKET__WRITE                         0x00000004UL
-#define KEY_SOCKET__ACCEPT                        0x00002000UL
 #define KEY_SOCKET__CONNECT                       0x00000800UL
-#define KEY_SOCKET__LOCK                          0x00000040UL
-#define KEY_SOCKET__IOCTL                         0x00000001UL
-#define KEY_SOCKET__CREATE                        0x00000008UL
-#define KEY_SOCKET__NAME_BIND                     0x00200000UL
-#define KEY_SOCKET__SEND_MSG                      0x00100000UL
+#define KEY_SOCKET__LISTEN                        0x00001000UL
+#define KEY_SOCKET__ACCEPT                        0x00002000UL
+#define KEY_SOCKET__GETOPT                        0x00004000UL
+#define KEY_SOCKET__SETOPT                        0x00008000UL
+#define KEY_SOCKET__SHUTDOWN                      0x00010000UL
 #define KEY_SOCKET__RECVFROM                      0x00020000UL
-#define KEY_SOCKET__GETATTR                       0x00000010UL
+#define KEY_SOCKET__SENDTO                        0x00040000UL
+#define KEY_SOCKET__RECV_MSG                      0x00080000UL
+#define KEY_SOCKET__SEND_MSG                      0x00100000UL
+#define KEY_SOCKET__NAME_BIND                     0x00200000UL
 
-#define UNIX_STREAM_SOCKET__RELABELTO             0x00000100UL
-#define UNIX_STREAM_SOCKET__RECV_MSG              0x00080000UL
+#define UNIX_STREAM_SOCKET__IOCTL                 0x00000001UL
+#define UNIX_STREAM_SOCKET__READ                  0x00000002UL
+#define UNIX_STREAM_SOCKET__WRITE                 0x00000004UL
+#define UNIX_STREAM_SOCKET__CREATE                0x00000008UL
+#define UNIX_STREAM_SOCKET__GETATTR               0x00000010UL
+#define UNIX_STREAM_SOCKET__SETATTR               0x00000020UL
+#define UNIX_STREAM_SOCKET__LOCK                  0x00000040UL
 #define UNIX_STREAM_SOCKET__RELABELFROM           0x00000080UL
-#define UNIX_STREAM_SOCKET__SETOPT                0x00008000UL
+#define UNIX_STREAM_SOCKET__RELABELTO             0x00000100UL
 #define UNIX_STREAM_SOCKET__APPEND                0x00000200UL
-#define UNIX_STREAM_SOCKET__SETATTR               0x00000020UL
-#define UNIX_STREAM_SOCKET__SENDTO                0x00040000UL
-#define UNIX_STREAM_SOCKET__GETOPT                0x00004000UL
-#define UNIX_STREAM_SOCKET__READ                  0x00000002UL
-#define UNIX_STREAM_SOCKET__SHUTDOWN              0x00010000UL
-#define UNIX_STREAM_SOCKET__LISTEN                0x00001000UL
 #define UNIX_STREAM_SOCKET__BIND                  0x00000400UL
-#define UNIX_STREAM_SOCKET__WRITE                 0x00000004UL
-#define UNIX_STREAM_SOCKET__ACCEPT                0x00002000UL
 #define UNIX_STREAM_SOCKET__CONNECT               0x00000800UL
-#define UNIX_STREAM_SOCKET__LOCK                  0x00000040UL
-#define UNIX_STREAM_SOCKET__IOCTL                 0x00000001UL
-#define UNIX_STREAM_SOCKET__CREATE                0x00000008UL
-#define UNIX_STREAM_SOCKET__NAME_BIND             0x00200000UL
-#define UNIX_STREAM_SOCKET__SEND_MSG              0x00100000UL
+#define UNIX_STREAM_SOCKET__LISTEN                0x00001000UL
+#define UNIX_STREAM_SOCKET__ACCEPT                0x00002000UL
+#define UNIX_STREAM_SOCKET__GETOPT                0x00004000UL
+#define UNIX_STREAM_SOCKET__SETOPT                0x00008000UL
+#define UNIX_STREAM_SOCKET__SHUTDOWN              0x00010000UL
 #define UNIX_STREAM_SOCKET__RECVFROM              0x00020000UL
-#define UNIX_STREAM_SOCKET__GETATTR               0x00000010UL
+#define UNIX_STREAM_SOCKET__SENDTO                0x00040000UL
+#define UNIX_STREAM_SOCKET__RECV_MSG              0x00080000UL
+#define UNIX_STREAM_SOCKET__SEND_MSG              0x00100000UL
+#define UNIX_STREAM_SOCKET__NAME_BIND             0x00200000UL
 
 #define UNIX_STREAM_SOCKET__CONNECTTO             0x00400000UL
 #define UNIX_STREAM_SOCKET__NEWCONN               0x00800000UL
 #define UNIX_STREAM_SOCKET__ACCEPTFROM            0x01000000UL
 
-#define UNIX_DGRAM_SOCKET__RELABELTO              0x00000100UL
-#define UNIX_DGRAM_SOCKET__RECV_MSG               0x00080000UL
+#define UNIX_DGRAM_SOCKET__IOCTL                  0x00000001UL
+#define UNIX_DGRAM_SOCKET__READ                   0x00000002UL
+#define UNIX_DGRAM_SOCKET__WRITE                  0x00000004UL
+#define UNIX_DGRAM_SOCKET__CREATE                 0x00000008UL
+#define UNIX_DGRAM_SOCKET__GETATTR                0x00000010UL
+#define UNIX_DGRAM_SOCKET__SETATTR                0x00000020UL
+#define UNIX_DGRAM_SOCKET__LOCK                   0x00000040UL
 #define UNIX_DGRAM_SOCKET__RELABELFROM            0x00000080UL
-#define UNIX_DGRAM_SOCKET__SETOPT                 0x00008000UL
+#define UNIX_DGRAM_SOCKET__RELABELTO              0x00000100UL
 #define UNIX_DGRAM_SOCKET__APPEND                 0x00000200UL
-#define UNIX_DGRAM_SOCKET__SETATTR                0x00000020UL
-#define UNIX_DGRAM_SOCKET__SENDTO                 0x00040000UL
-#define UNIX_DGRAM_SOCKET__GETOPT                 0x00004000UL
-#define UNIX_DGRAM_SOCKET__READ                   0x00000002UL
-#define UNIX_DGRAM_SOCKET__SHUTDOWN               0x00010000UL
-#define UNIX_DGRAM_SOCKET__LISTEN                 0x00001000UL
 #define UNIX_DGRAM_SOCKET__BIND                   0x00000400UL
-#define UNIX_DGRAM_SOCKET__WRITE                  0x00000004UL
-#define UNIX_DGRAM_SOCKET__ACCEPT                 0x00002000UL
 #define UNIX_DGRAM_SOCKET__CONNECT                0x00000800UL
-#define UNIX_DGRAM_SOCKET__LOCK                   0x00000040UL
-#define UNIX_DGRAM_SOCKET__IOCTL                  0x00000001UL
-#define UNIX_DGRAM_SOCKET__CREATE                 0x00000008UL
-#define UNIX_DGRAM_SOCKET__NAME_BIND              0x00200000UL
-#define UNIX_DGRAM_SOCKET__SEND_MSG               0x00100000UL
+#define UNIX_DGRAM_SOCKET__LISTEN                 0x00001000UL
+#define UNIX_DGRAM_SOCKET__ACCEPT                 0x00002000UL
+#define UNIX_DGRAM_SOCKET__GETOPT                 0x00004000UL
+#define UNIX_DGRAM_SOCKET__SETOPT                 0x00008000UL
+#define UNIX_DGRAM_SOCKET__SHUTDOWN               0x00010000UL
 #define UNIX_DGRAM_SOCKET__RECVFROM               0x00020000UL
-#define UNIX_DGRAM_SOCKET__GETATTR                0x00000010UL
+#define UNIX_DGRAM_SOCKET__SENDTO                 0x00040000UL
+#define UNIX_DGRAM_SOCKET__RECV_MSG               0x00080000UL
+#define UNIX_DGRAM_SOCKET__SEND_MSG               0x00100000UL
+#define UNIX_DGRAM_SOCKET__NAME_BIND              0x00200000UL
 
 #define PROCESS__FORK                             0x00000001UL
 #define PROCESS__TRANSITION                       0x00000002UL
@@ -457,50 +459,50 @@
 #define PROCESS__SETRLIMIT                        0x00200000UL
 #define PROCESS__RLIMITINH                        0x00400000UL
 
+#define IPC__CREATE                               0x00000001UL
+#define IPC__DESTROY                              0x00000002UL
+#define IPC__GETATTR                              0x00000004UL
 #define IPC__SETATTR                              0x00000008UL
 #define IPC__READ                                 0x00000010UL
+#define IPC__WRITE                                0x00000020UL
 #define IPC__ASSOCIATE                            0x00000040UL
-#define IPC__DESTROY                              0x00000002UL
-#define IPC__UNIX_WRITE                           0x00000100UL
-#define IPC__CREATE                               0x00000001UL
 #define IPC__UNIX_READ                            0x00000080UL
-#define IPC__GETATTR                              0x00000004UL
-#define IPC__WRITE                                0x00000020UL
+#define IPC__UNIX_WRITE                           0x00000100UL
 
+#define SEM__CREATE                               0x00000001UL
+#define SEM__DESTROY                              0x00000002UL
+#define SEM__GETATTR                              0x00000004UL
 #define SEM__SETATTR                              0x00000008UL
 #define SEM__READ                                 0x00000010UL
+#define SEM__WRITE                                0x00000020UL
 #define SEM__ASSOCIATE                            0x00000040UL
-#define SEM__DESTROY                              0x00000002UL
-#define SEM__UNIX_WRITE                           0x00000100UL
-#define SEM__CREATE                               0x00000001UL
 #define SEM__UNIX_READ                            0x00000080UL
-#define SEM__GETATTR                              0x00000004UL
-#define SEM__WRITE                                0x00000020UL
+#define SEM__UNIX_WRITE                           0x00000100UL
 
+#define MSGQ__CREATE                              0x00000001UL
+#define MSGQ__DESTROY                             0x00000002UL
+#define MSGQ__GETATTR                             0x00000004UL
 #define MSGQ__SETATTR                             0x00000008UL
 #define MSGQ__READ                                0x00000010UL
+#define MSGQ__WRITE                               0x00000020UL
 #define MSGQ__ASSOCIATE                           0x00000040UL
-#define MSGQ__DESTROY                             0x00000002UL
-#define MSGQ__UNIX_WRITE                          0x00000100UL
-#define MSGQ__CREATE                              0x00000001UL
 #define MSGQ__UNIX_READ                           0x00000080UL
-#define MSGQ__GETATTR                             0x00000004UL
-#define MSGQ__WRITE                               0x00000020UL
+#define MSGQ__UNIX_WRITE                          0x00000100UL
 
 #define MSGQ__ENQUEUE                             0x00000200UL
 
 #define MSG__SEND                                 0x00000001UL
 #define MSG__RECEIVE                              0x00000002UL
 
+#define SHM__CREATE                               0x00000001UL
+#define SHM__DESTROY                              0x00000002UL
+#define SHM__GETATTR                              0x00000004UL
 #define SHM__SETATTR                              0x00000008UL
 #define SHM__READ                                 0x00000010UL
+#define SHM__WRITE                                0x00000020UL
 #define SHM__ASSOCIATE                            0x00000040UL
-#define SHM__DESTROY                              0x00000002UL
-#define SHM__UNIX_WRITE                           0x00000100UL
-#define SHM__CREATE                               0x00000001UL
 #define SHM__UNIX_READ                            0x00000080UL
-#define SHM__GETATTR                              0x00000004UL
-#define SHM__WRITE                                0x00000020UL
+#define SHM__UNIX_WRITE                           0x00000100UL
 
 #define SHM__LOCK                                 0x00000200UL
 
@@ -552,6 +554,104 @@
 #define PASSWD__PASSWD                            0x00000001UL
 #define PASSWD__CHFN                              0x00000002UL
 #define PASSWD__CHSH                              0x00000004UL
+#define PASSWD__ROOTOK                            0x00000008UL
+
+#define DRAWABLE__CREATE                          0x00000001UL
+#define DRAWABLE__DESTROY                         0x00000002UL
+#define DRAWABLE__DRAW                            0x00000004UL
+#define DRAWABLE__COPY                            0x00000008UL
+#define DRAWABLE__GETATTR                         0x00000010UL
+
+#define GC__CREATE                                0x00000001UL
+#define GC__FREE                                  0x00000002UL
+#define GC__GETATTR                               0x00000004UL
+#define GC__SETATTR                               0x00000008UL
+
+#define WINDOW__ADDCHILD                          0x00000001UL
+#define WINDOW__CREATE                            0x00000002UL
+#define WINDOW__DESTROY                           0x00000004UL
+#define WINDOW__MAP                               0x00000008UL
+#define WINDOW__UNMAP                             0x00000010UL
+#define WINDOW__CHSTACK                           0x00000020UL
+#define WINDOW__CHPROPLIST                        0x00000040UL
+#define WINDOW__CHPROP                            0x00000080UL
+#define WINDOW__LISTPROP                          0x00000100UL
+#define WINDOW__GETATTR                           0x00000200UL
+#define WINDOW__SETATTR                           0x00000400UL
+#define WINDOW__SETFOCUS                          0x00000800UL
+#define WINDOW__MOVE                              0x00001000UL
+#define WINDOW__CHSELECTION                       0x00002000UL
+#define WINDOW__CHPARENT                          0x00004000UL
+#define WINDOW__CTRLLIFE                          0x00008000UL
+#define WINDOW__ENUMERATE                         0x00010000UL
+#define WINDOW__TRANSPARENT                       0x00020000UL
+#define WINDOW__MOUSEMOTION                       0x00040000UL
+#define WINDOW__CLIENTCOMEVENT                    0x00080000UL
+#define WINDOW__INPUTEVENT                        0x00100000UL
+#define WINDOW__DRAWEVENT                         0x00200000UL
+#define WINDOW__WINDOWCHANGEEVENT                 0x00400000UL
+#define WINDOW__WINDOWCHANGEREQUEST               0x00800000UL
+#define WINDOW__SERVERCHANGEEVENT                 0x01000000UL
+#define WINDOW__EXTENSIONEVENT                    0x02000000UL
+
+#define FONT__LOAD                                0x00000001UL
+#define FONT__FREE                                0x00000002UL
+#define FONT__GETATTR                             0x00000004UL
+#define FONT__USE                                 0x00000008UL
+
+#define COLORMAP__CREATE                          0x00000001UL
+#define COLORMAP__FREE                            0x00000002UL
+#define COLORMAP__INSTALL                         0x00000004UL
+#define COLORMAP__UNINSTALL                       0x00000008UL
+#define COLORMAP__LIST                            0x00000010UL
+#define COLORMAP__READ                            0x00000020UL
+#define COLORMAP__STORE                           0x00000040UL
+#define COLORMAP__GETATTR                         0x00000080UL
+#define COLORMAP__SETATTR                         0x00000100UL
+
+#define PROPERTY__CREATE                          0x00000001UL
+#define PROPERTY__FREE                            0x00000002UL
+#define PROPERTY__READ                            0x00000004UL
+#define PROPERTY__WRITE                           0x00000008UL
+
+#define CURSOR__CREATE                            0x00000001UL
+#define CURSOR__CREATEGLYPH                       0x00000002UL
+#define CURSOR__FREE                              0x00000004UL
+#define CURSOR__ASSIGN                            0x00000008UL
+#define CURSOR__SETATTR                           0x00000010UL
+
+#define XCLIENT__KILL                             0x00000001UL
+
+#define XINPUT__LOOKUP                            0x00000001UL
+#define XINPUT__GETATTR                           0x00000002UL
+#define XINPUT__SETATTR                           0x00000004UL
+#define XINPUT__SETFOCUS                          0x00000008UL
+#define XINPUT__WARPPOINTER                       0x00000010UL
+#define XINPUT__ACTIVEGRAB                        0x00000020UL
+#define XINPUT__PASSIVEGRAB                       0x00000040UL
+#define XINPUT__UNGRAB                            0x00000080UL
+#define XINPUT__BELL                              0x00000100UL
+#define XINPUT__MOUSEMOTION                       0x00000200UL
+#define XINPUT__RELABELINPUT                      0x00000400UL
+
+#define XSERVER__SCREENSAVER                      0x00000001UL
+#define XSERVER__GETHOSTLIST                      0x00000002UL
+#define XSERVER__SETHOSTLIST                      0x00000004UL
+#define XSERVER__GETFONTPATH                      0x00000008UL
+#define XSERVER__SETFONTPATH                      0x00000010UL
+#define XSERVER__GETATTR                          0x00000020UL
+#define XSERVER__GRAB                             0x00000040UL
+#define XSERVER__UNGRAB                           0x00000080UL
+
+#define XEXTENSION__QUERY                         0x00000001UL
+#define XEXTENSION__USE                           0x00000002UL
+
+#define PAX__PAGEEXEC                             0x00000001UL
+#define PAX__EMUTRAMP                             0x00000002UL
+#define PAX__MPROTECT                             0x00000004UL
+#define PAX__RANDMMAP                             0x00000008UL
+#define PAX__RANDEXEC                             0x00000010UL
+#define PAX__SEGMEXEC                             0x00000020UL
 
 
 /* FLASK */
Index: linux-2.6/security/selinux/include/class_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/class_to_string.h,v
retrieving revision 1.4
diff -u -r1.4 class_to_string.h
--- linux-2.6/security/selinux/include/class_to_string.h	10 May 2004 13:01:09 -0000	1.4
+++ linux-2.6/security/selinux/include/class_to_string.h	26 May 2004 15:36:03 -0000
@@ -35,5 +35,17 @@
     "shm",
     "ipc",
     "passwd",
+    "drawable",
+    "window",
+    "gc",
+    "font",
+    "colormap",
+    "property",
+    "cursor",
+    "xclient",
+    "xinput",
+    "xserver",
+    "xextension",
+    "pax",
 };
 
Index: linux-2.6/security/selinux/include/flask.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/flask.h,v
retrieving revision 1.7
diff -u -r1.7 flask.h
--- linux-2.6/security/selinux/include/flask.h	10 May 2004 13:09:02 -0000	1.7
+++ linux-2.6/security/selinux/include/flask.h	26 May 2004 15:36:03 -0000
@@ -35,6 +35,18 @@
 #define SECCLASS_SHM                                     28
 #define SECCLASS_IPC                                     29
 #define SECCLASS_PASSWD                                  30
+#define SECCLASS_DRAWABLE                                31
+#define SECCLASS_WINDOW                                  32
+#define SECCLASS_GC                                      33
+#define SECCLASS_FONT                                    34
+#define SECCLASS_COLORMAP                                35
+#define SECCLASS_PROPERTY                                36
+#define SECCLASS_CURSOR                                  37
+#define SECCLASS_XCLIENT                                 38
+#define SECCLASS_XINPUT                                  39
+#define SECCLASS_XSERVER                                 40
+#define SECCLASS_XEXTENSION                              41
+#define SECCLASS_PAX                                     42
 
 /*
  * Security identifier indices for initial entities





