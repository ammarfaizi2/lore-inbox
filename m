Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbVFVB0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbVFVB0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVFVBZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:25:56 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:48537 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S262472AbVFVBYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:24:24 -0400
Message-Id: <200506220124.j5M1OHgJ009772@ms-smtp-04.texas.rr.com>
From: ericvh@gmail.com
Date: Tue, 21 Jun 2005 20:23:04 -0500
To: linux-kernel@vger.kernel.org
Subject: [-mm PATCH] v9fs: Change error magic numbers to defined constants
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change magic error numbers to system defined constants in v9fs error.h
As suggested by Jan-Benedict Glaw.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit da6dde6453bdefc66ae7f162dc4d212af8e2b353
tree 3b940a9c02b7d1f2ea9e2406e3a02b60c23f16e0
parent d69bf28ad7f2098cef822023c93f49ce556a72d9
author Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:09:04 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Tue, 21 Jun 2005 20:09:04 -0500

 fs/9p/error.h |  158 ++++++++++++++++++++++++++++-----------------------------
 1 files changed, 77 insertions(+), 81 deletions(-)

diff --git a/fs/9p/error.h b/fs/9p/error.h
--- a/fs/9p/error.h
+++ b/fs/9p/error.h
@@ -30,6 +30,7 @@
  */
 
 #include <linux/errno.h>
+#include <asm/errno.h>
 
 struct errormap {
 	char *name;
@@ -43,87 +44,82 @@ static struct hlist_head hash_errmap[ERR
 
 /* FixMe - reduce to a reasonable size */
 static struct errormap errmap[] = {
-	{"Operation not permitted", 1},
-	{"wstat prohibited", 1},
-	{"No such file or directory", 2},
-	{"file not found", 2},
-	{"Interrupted system call", 4},
-	{"Input/output error", 5},
-	{"No such device or address", 6},
-	{"Argument list too long", 7},
-	{"Bad file descriptor", 9},
-	{"Resource temporarily unavailable", 11},
-	{"Cannot allocate memory", 12},
-	{"Permission denied", 13},
-	{"Bad address", 14},
-	{"Block device required", 15},
-	{"Device or resource busy", 16},
-	{"File exists", 17},
-	{"Invalid cross-device link", 18},
-	{"No such device", 19},
-	{"Not a directory", 20},
-	{"Is a directory", 21},
-	{"Invalid argument", 22},
-	{"Too many open files in system", 23},
-	{"Too many open files", 24},
-	{"Text file busy", 26},
-	{"File too large", 27},
-	{"No space left on device", 28},
-	{"Illegal seek", 29},
-	{"Read-only file system", 30},
-	{"Too many links", 31},
-	{"Broken pipe", 32},
-	{"Numerical argument out of domain", 33},
-	{"Numerical result out of range", 34},
-	{"Resource deadlock avoided", 35},
-	{"File name too long", 36},
-	{"No locks available", 37},
-	{"Function not implemented", 38},
-	{"Directory not empty", 39},
-	{"Too many levels of symbolic links", 40},
-	{"Unknown error 41", 41},
-	{"No message of desired type", 42},
-	{"Identifier removed", 43},
-	{"File locking deadlock error", 58},
-	{"No data available", 61},
-	{"Machine is not on the network", 64},
-	{"Package not installed", 65},
-	{"Object is remote", 66},
-	{"Link has been severed", 67},
-	{"Communication error on send", 70},
-	{"Protocol error", 71},
-	{"Bad message", 74},
-	{"File descriptor in bad state", 77},
-	{"Streams pipe error", 86},
-	{"Too many users", 87},
-	{"Socket operation on non-socket", 88},
-	{"Message too long", 90},
-	{"Protocol not available", 92},
-	{"Protocol not supported", 93},
-	{"Socket type not supported", 94},
-	{"Operation not supported", 95},
-	{"Protocol family not supported", 96},
-	{"Network is down", 100},
-	{"Network is unreachable", 101},
-	{"Network dropped connection on reset", 102},
-	{"Software caused connection abort", 103},
-	{"Connection reset by peer", 104},
-	{"No buffer space available", 105},
-	{"Transport endpoint is already connected", 106},
-	{"Transport endpoint is not connected", 107},
-	{"Cannot send after transport endpoint shutdown", 108},
-	{"Connection timed out", 110},
-	{"Connection refused", 111},
-	{"Host is down", 112},
-	{"No route to host", 113},
-	{"Operation already in progress", 114},
-	{"Operation now in progress", 115},
-	{"Is a named type file", 120},
-	{"Remote I/O error", 121},
-	{"Disk quota exceeded", 122},
-	{"Operation canceled", 125},
-	{"Unknown error 126", 126},
-	{"Unknown error 127", 127},
+	{"Operation not permitted", EPERM},
+	{"wstat prohibited", EPERM},
+	{"No such file or directory", ENOENT},
+	{"file not found", ENOENT},
+	{"Interrupted system call", EINTR},
+	{"Input/output error", EIO},
+	{"No such device or address", ENXIO},
+	{"Argument list too long", E2BIG},
+	{"Bad file descriptor", EBADF},
+	{"Resource temporarily unavailable", EAGAIN},
+	{"Cannot allocate memory", ENOMEM},
+	{"Permission denied", EACCES},
+	{"Bad address", EFAULT},
+	{"Block device required", ENOTBLK},
+	{"Device or resource busy", EBUSY},
+	{"File exists", EEXIST},
+	{"Invalid cross-device link", EXDEV},
+	{"No such device", ENODEV},
+	{"Not a directory", ENOTDIR},
+	{"Is a directory", EISDIR},
+	{"Invalid argument", EINVAL},
+	{"Too many open files in system", ENFILE},
+	{"Too many open files", EMFILE},
+	{"Text file busy", ETXTBSY},
+	{"File too large", EFBIG},
+	{"No space left on device", ENOSPC},
+	{"Illegal seek", ESPIPE},
+	{"Read-only file system", EROFS},
+	{"Too many links", EMLINK},
+	{"Broken pipe", EPIPE},
+	{"Numerical argument out of domain", EDOM},
+	{"Numerical result out of range", ERANGE},
+	{"Resource deadlock avoided", EDEADLK},
+	{"File name too long", ENAMETOOLONG},
+	{"No locks available", ENOLCK},
+	{"Function not implemented", ENOSYS},
+	{"Directory not empty", ENOTEMPTY},
+	{"Too many levels of symbolic links", ELOOP},
+	{"No message of desired type", ENOMSG},
+	{"Identifier removed", EIDRM},
+	{"No data available", ENODATA},
+	{"Machine is not on the network", ENONET},
+	{"Package not installed", ENOPKG},
+	{"Object is remote", EREMOTE},
+	{"Link has been severed", ENOLINK},
+	{"Communication error on send", ECOMM},
+	{"Protocol error", EPROTO},
+	{"Bad message", EBADMSG},
+	{"File descriptor in bad state", EBADFD},
+	{"Streams pipe error", ESTRPIPE},
+	{"Too many users", EUSERS},
+	{"Socket operation on non-socket", ENOTSOCK},
+	{"Message too long", EMSGSIZE},
+	{"Protocol not available", ENOPROTOOPT},
+	{"Protocol not supported", EPROTONOSUPPORT},
+	{"Socket type not supported", ESOCKTNOSUPPORT},
+	{"Operation not supported", EOPNOTSUPP},
+	{"Protocol family not supported", EPFNOSUPPORT},
+	{"Network is down", ENETDOWN},
+	{"Network is unreachable", ENETUNREACH},
+	{"Network dropped connection on reset", ENETRESET},
+	{"Software caused connection abort", ECONNABORTED},
+	{"Connection reset by peer", ECONNRESET},
+	{"No buffer space available", ENOBUFS},
+	{"Transport endpoint is already connected", EISCONN},
+	{"Transport endpoint is not connected", ENOTCONN},
+	{"Cannot send after transport endpoint shutdown", ESHUTDOWN},
+	{"Connection timed out", ETIMEDOUT},
+	{"Connection refused", ECONNREFUSED},
+	{"Host is down", EHOSTDOWN},
+	{"No route to host", EHOSTUNREACH},
+	{"Operation already in progress", EALREADY},
+	{"Operation now in progress", EINPROGRESS},
+	{"Is a named type file", EISNAM},
+	{"Remote I/O error", EREMOTEIO},
+	{"Disk quota exceeded", EDQUOT},
 /* errors from fossil, vacfs, and u9fs */
 	{"fid unknown or out of range", EBADF},
 	{"permission denied", EACCES},
