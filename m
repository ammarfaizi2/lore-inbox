Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315257AbSFCMWS>; Mon, 3 Jun 2002 08:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315213AbSFCMWR>; Mon, 3 Jun 2002 08:22:17 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:31988 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S314500AbSFCMWL>;
	Mon, 3 Jun 2002 08:22:11 -0400
Message-ID: <3CFB5F2E.5000601@nokia.com>
Date: Mon, 03 Jun 2002 15:21:02 +0300
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
CC: affix-devel@lists.sourceforge.net,
        Affix support <affix-support@lists.sourceforge.net>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [recall] for patch
In-Reply-To: <3C500D09.4080206@nokia.com> <3C5AB093.5050405@nokia.com> <3C5E4991.6010707@nokia.com> <3C628D6A.2050900@nokia.com> <3C628DCF.40700@nokia.com> <3C6D25F6.4010905@nokia.com> <3C766511.5050808@nokia.com> <3C7F6C0C.6030204@nokia.com> <3C877AC7.8090008@nokia.com> <3C92111C.1070107@nokia.com> <3CA3A149.1080905@nokia.com> <3CAE2484.8090304@nokia.com> <3CB99689.7090105@nokia.com> <3CEEC240.8030905@nokia.com> <3CF8217D.1090903@nokia.com> <3CFB4A82.3000007@nokia.com>
Content-Type: multipart/mixed;
 boundary="------------060609070909060403050806"
X-OriginalArrivalTime: 03 Jun 2002 12:22:09.0874 (UTC) FILETIME=[4877CB20:01C20AF9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060609070909060403050806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please ignore the Affix-1_00pre2.patch

Use this one
Affix-1_00pre2.patch.1

br, Dmitry


Dmitry Kasatkin wrote:
> Hi,
> 
> Small patch. Otherwise PCMCIA will not work (modules went to invalid 
> place).
> 
> br, Dmitry
> 
> Kasatkin Dmitry (NRC/Helsinki) wrote:
> 
>> Hi All,
>>
>> Find new Affix release Affix-1_00pre2 on http://affix.sourceforge.net
>> It has improved UART, USB and extra drivers.
>> Anycom cards supported
>>
>> Version 1.0pre2 [31.05.2002]
>> - [new] new drivers for *bluecard* cards (Anycom) and 3COM cards
>> - [new] cross-compiling support (ARM, PowerPC,...)
>> - [new] *open_uart* accept speed (no need to call stty)
>> - [fix] affix_uart support Xircom cards
>> - [changes] libbt*.so libs moved to libaffix*.so
>> - [fix] now can be compiled on kernels <= 2.4.6
>>
>>
>> Profiles supported:
>> - Service Discovery.
>> - Serial Port.
>> - LAN Access.
>> - Dialup Networking.
>> - OBEX Object Push.
>> - OBEX File Transfer.
>> - PAN.
>>
>>
>> GUI environment A.F.E - Affix Frontend Environment available for use.
>> http://affix.sourceforge.net/afe
>>
>> Link can be found on Affix WEB site in *Links* section.
>>
>> br, Dmitry
>> +358 50 4836365
>>
>>
>>
> 
> 
> ------------------------------------------------------------------------
> 
> diff -Naur Affix-1_00pre2/Configure affix/Configure
> --- Affix-1_00pre2/Configure	Sat Jun  1 03:07:45 2002
> +++ affix/Configure	Mon Jun  3 13:48:41 2002
> @@ -19,7 +19,7 @@
>  #   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>  #
>  #
> -#   $Id: Configure,v 2.48 2002/06/01 00:07:45 kds Exp $
> +#   $Id: Configure,v 2.50 2002/06/03 10:48:41 kds Exp $
>  #
>  #   Configuration script (adopted from PCMCIA package) 
>  #   
> @@ -403,19 +403,12 @@
>  
>  
>  if [ "$CONFIG_MODVERSIONS" = "y" ] ; then
> -    if [ $CONF_SRC != 1 ] ; then
>  	MODVER="$LINUX/include/linux/$MODVER"
>  	if [ ! -r "$MODVER" ] ; then
>  	    echo "$MODVER does not exist!"
>  	    echo "    To fix, run 'make dep' in $LINUX."
>  	    fail
>  	fi
> -    else
> -	# use running kernel
> -	mv $MODVER include/affix
> -	ln -sf ../../../include/affix/$MODVER ./kernel/include/linux/$MODVER
> -	MODVER="$BTDIR/kernel/include/linux/$MODVER"
> -    fi
>  else
>      rm -f $MODVER
>  fi
> @@ -474,6 +467,34 @@
>  CPPFLAGS_KERNEL="$CPPFLAGS_KERNEL -D__KERNEL__ -DMODULE $MFLAG"
>  LDFLAGS="${CROSS_LDFLAGS:-}"
>  
> +#=======================================================================
> +
> +# How should the startup scripts be configured?
> +
> +if [ "$PREFIX" = "" ] ; then
> +    if [ -d /sbin/init.d -o -d /etc/rc.d/init.d -o -d /etc/init.d ] ; then
> +	echo "It looks like you have a System V init file setup."
> +	SYSV_INIT=y
> +	if [ -d /sbin/init.d ] ; then
> +	    RC_DIR=/sbin/init.d
> +	elif [ -d /etc/rc.d/init.d ] ; then
> +	    RC_DIR=/etc/rc.d
> +	else
> +	    RC_DIR=/etc
> +	fi
> +    else
> +	echo "It looks like you have a BSD-ish init file setup."
> +	SYSV_INIT=
> +    fi
> +else
> +    ask_bool "System V init script layout" SYSV_INIT
> +    if [ "$SYSV_INIT" = "y" ] ; then
> +	ask_str "Top-level directory for RC scripts" RC_DIR
> +    fi
> +fi
> +
> +echo ""
> +
>  
>  #=======================================================================
>  
> @@ -503,42 +524,12 @@
>  	write_str_ne $x
>  done
>  for x in CROSS_COMPILE CROSS_CPPFLAGS CROSS_LDFLAGS \
> -	 BTDIR LINUX PREFIX PROGDIR LIBDIR RCDIR ARCH HOST_ARCH \
> +	 BTDIR LINUX PREFIX PROGDIR MODDIR LIBDIR RCDIR ARCH HOST_ARCH SYSV_INIT RC_DIR \
>  	 CPPFLAGS_KERNEL CPPFLAGS CFLAGS LDFLAGS CPPFLAGS_GLIB LDFLAGS_GLIB \
>  	 CPPFLAGS_OBEX LDFLAGS_OBEX; do
>      write_str_cfg $x
>  done
>  write_nl
> -
> -#=======================================================================
> -
> -# How should the startup scripts be configured?
> -
> -if [ "$PREFIX" = "" ] ; then
> -    if [ -d /sbin/init.d -o -d /etc/rc.d/init.d -o -d /etc/init.d ] ; then
> -	echo "It looks like you have a System V init file setup."
> -	SYSV_INIT=y
> -	if [ -d /sbin/init.d ] ; then
> -	    RC_DIR=/sbin/init.d
> -	elif [ -d /etc/rc.d/init.d ] ; then
> -	    RC_DIR=/etc/rc.d
> -	else
> -	    RC_DIR=/etc
> -	fi
> -    else
> -	echo "It looks like you have a BSD-ish init file setup."
> -	SYSV_INIT=
> -    fi
> -    write_bool SYSV_INIT
> -    if [ "$SYSV_INIT" = "y" ] ; then write_str_cfg RC_DIR ; fi
> -else
> -    ask_bool "System V init script layout" SYSV_INIT
> -    if [ "$SYSV_INIT" = "y" ] ; then
> -	ask_str "Top-level directory for RC scripts" RC_DIR
> -    fi
> -fi
> -
> -echo ""
>  
>  #=======================================================================
>  
> diff -Naur Affix-1_00pre2/etc/Makefile affix/etc/Makefile
> --- Affix-1_00pre2/etc/Makefile	Fri May 31 01:44:35 2002
> +++ affix/etc/Makefile	Mon Jun  3 13:34:36 2002
> @@ -18,7 +18,7 @@
>  #   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
>  #
>  #
> -#   $Id: Makefile,v 1.25 2002/05/30 22:44:35 kds Exp $
> +#   $Id: Makefile,v 1.26 2002/06/03 10:34:36 kds Exp $
>  #
>  #   Makefile for installing scripts
>  #
> @@ -50,7 +50,7 @@
>  	install -m 0755 -d $(PREFIX)/etc/ppp/ip-down.d
>  	install -m 0555 ./affix/masq-down $(PREFIX)/etc/ppp/ip-down.d
>  
> -	if [ -d /etc/modutils ] ; then \
> +	@if [ -d /etc/modutils ] ; then \
>  		install -m 0644 ./modutils /etc/modutils/affix; \
>  		update-modules; \
>  	fi


-- 
  Dmitry Kasatkin
  Nokia Research Center / Helsinki
  Mobile: +358 50 4836365
  E-Mail: dmitry.kasatkin@nokia.com

--------------060609070909060403050806
Content-Type: text/plain;
 name="Affix-1_00pre2.patch.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Affix-1_00pre2.patch.1"

diff -Naur Affix-1_00pre2/Configure affix/Configure
--- Affix-1_00pre2/Configure	Sat Jun  1 03:07:45 2002
+++ affix/Configure	Mon Jun  3 13:48:41 2002
@@ -19,7 +19,7 @@
 #   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 #
 #
-#   $Id: Configure,v 2.48 2002/06/01 00:07:45 kds Exp $
+#   $Id: Configure,v 2.50 2002/06/03 10:48:41 kds Exp $
 #
 #   Configuration script (adopted from PCMCIA package) 
 #   
@@ -403,19 +403,12 @@
 
 
 if [ "$CONFIG_MODVERSIONS" = "y" ] ; then
-    if [ $CONF_SRC != 1 ] ; then
 	MODVER="$LINUX/include/linux/$MODVER"
 	if [ ! -r "$MODVER" ] ; then
 	    echo "$MODVER does not exist!"
 	    echo "    To fix, run 'make dep' in $LINUX."
 	    fail
 	fi
-    else
-	# use running kernel
-	mv $MODVER include/affix
-	ln -sf ../../../include/affix/$MODVER ./kernel/include/linux/$MODVER
-	MODVER="$BTDIR/kernel/include/linux/$MODVER"
-    fi
 else
     rm -f $MODVER
 fi
@@ -474,6 +467,34 @@
 CPPFLAGS_KERNEL="$CPPFLAGS_KERNEL -D__KERNEL__ -DMODULE $MFLAG"
 LDFLAGS="${CROSS_LDFLAGS:-}"
 
+#=======================================================================
+
+# How should the startup scripts be configured?
+
+if [ "$PREFIX" = "" ] ; then
+    if [ -d /sbin/init.d -o -d /etc/rc.d/init.d -o -d /etc/init.d ] ; then
+	echo "It looks like you have a System V init file setup."
+	SYSV_INIT=y
+	if [ -d /sbin/init.d ] ; then
+	    RC_DIR=/sbin/init.d
+	elif [ -d /etc/rc.d/init.d ] ; then
+	    RC_DIR=/etc/rc.d
+	else
+	    RC_DIR=/etc
+	fi
+    else
+	echo "It looks like you have a BSD-ish init file setup."
+	SYSV_INIT=
+    fi
+else
+    ask_bool "System V init script layout" SYSV_INIT
+    if [ "$SYSV_INIT" = "y" ] ; then
+	ask_str "Top-level directory for RC scripts" RC_DIR
+    fi
+fi
+
+echo ""
+
 
 #=======================================================================
 
@@ -503,42 +524,12 @@
 	write_str_ne $x
 done
 for x in CROSS_COMPILE CROSS_CPPFLAGS CROSS_LDFLAGS \
-	 BTDIR LINUX PREFIX PROGDIR LIBDIR RCDIR ARCH HOST_ARCH \
+	 BTDIR LINUX PREFIX PROGDIR MODDIR LIBDIR RCDIR ARCH HOST_ARCH SYSV_INIT RC_DIR \
 	 CPPFLAGS_KERNEL CPPFLAGS CFLAGS LDFLAGS CPPFLAGS_GLIB LDFLAGS_GLIB \
 	 CPPFLAGS_OBEX LDFLAGS_OBEX; do
     write_str_cfg $x
 done
 write_nl
-
-#=======================================================================
-
-# How should the startup scripts be configured?
-
-if [ "$PREFIX" = "" ] ; then
-    if [ -d /sbin/init.d -o -d /etc/rc.d/init.d -o -d /etc/init.d ] ; then
-	echo "It looks like you have a System V init file setup."
-	SYSV_INIT=y
-	if [ -d /sbin/init.d ] ; then
-	    RC_DIR=/sbin/init.d
-	elif [ -d /etc/rc.d/init.d ] ; then
-	    RC_DIR=/etc/rc.d
-	else
-	    RC_DIR=/etc
-	fi
-    else
-	echo "It looks like you have a BSD-ish init file setup."
-	SYSV_INIT=
-    fi
-    write_bool SYSV_INIT
-    if [ "$SYSV_INIT" = "y" ] ; then write_str_cfg RC_DIR ; fi
-else
-    ask_bool "System V init script layout" SYSV_INIT
-    if [ "$SYSV_INIT" = "y" ] ; then
-	ask_str "Top-level directory for RC scripts" RC_DIR
-    fi
-fi
-
-echo ""
 
 #=======================================================================
 
diff -Naur Affix-1_00pre2/README affix/README
--- Affix-1_00pre2/README	Sat Jun  1 04:07:57 2002
+++ affix/README	Mon Jun  3 15:17:57 2002
@@ -213,7 +213,11 @@
 	6) Update system configuration.
 
   	- For PCMCIA Bluetooth devices:
-	   For Nokia Connectivity Card the following lines should added to
+	   Affix installer copies configuration files from etc/pcmcia to
+	   /etc/pcmcia for all supported PCMCIA devices. Check if your PCMCIA
+	   configuration read those files automaticaly.
+	   Otherwise you need add some configuration options manually, e.g.
+	   for Nokia DTL-1/DTL-4 the following lines should added to
 	   the /etc/pcmcia/config file:
 	   a) to the device driver definitions
 		device "affix_uart_cs"
@@ -222,6 +226,8 @@
 		card "Nokia Mobile Phones DTL-1"
 		    manfid 0x0124, 0x1000
 		    bind "affix_uart_cs"
+
+	   ->> Please check etc/pcmcia of all available options.
 
 	- For USB Bluetooth devices:
 	    Install the hot-plug package if automatic loading of the "affix_usb.o"
diff -Naur Affix-1_00pre2/etc/Makefile affix/etc/Makefile
--- Affix-1_00pre2/etc/Makefile	Fri May 31 01:44:35 2002
+++ affix/etc/Makefile	Mon Jun  3 13:34:36 2002
@@ -18,7 +18,7 @@
 #   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 #
 #
-#   $Id: Makefile,v 1.25 2002/05/30 22:44:35 kds Exp $
+#   $Id: Makefile,v 1.26 2002/06/03 10:34:36 kds Exp $
 #
 #   Makefile for installing scripts
 #
@@ -50,7 +50,7 @@
 	install -m 0755 -d $(PREFIX)/etc/ppp/ip-down.d
 	install -m 0555 ./affix/masq-down $(PREFIX)/etc/ppp/ip-down.d
 
-	if [ -d /etc/modutils ] ; then \
+	@if [ -d /etc/modutils ] ; then \
 		install -m 0644 ./modutils /etc/modutils/affix; \
 		update-modules; \
 	fi
diff -Naur Affix-1_00pre2/kernel/Makefile affix/kernel/Makefile
--- Affix-1_00pre2/kernel/Makefile	Fri May 31 18:23:29 2002
+++ affix/kernel/Makefile	Mon Jun  3 14:57:38 2002
@@ -18,7 +18,7 @@
 #   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 #
 #
-#   $Id: Makefile,v 2.32 2002/05/31 15:23:29 kds Exp $
+#   $Id: Makefile,v 2.33 2002/06/03 11:57:38 kds Exp $
 #
 #   Makefile for compiling core module of the bluetooth stack
 #
@@ -73,7 +73,7 @@
 DMODULE = affix.o
 
 all:	subdirs $(MODULE)
-	echo $(DIRS)
+#	echo $(DIRS)
 
 subdirs:
 	@set -e; for d in $(DIRS); do $(MAKE) -C $$d all; done
diff -Naur Affix-1_00pre2/kernel/btcore/hci_mgr.c affix/kernel/btcore/hci_mgr.c
--- Affix-1_00pre2/kernel/btcore/hci_mgr.c	Fri May 31 18:23:29 2002
+++ affix/kernel/btcore/hci_mgr.c	Mon Jun  3 14:57:38 2002
@@ -19,7 +19,7 @@
 */
 
 /* 
-   $Id: hci_mgr.c,v 2.58 2002/05/31 15:23:29 kds Exp $
+   $Id: hci_mgr.c,v 2.59 2002/06/03 11:57:38 kds Exp $
 
    HCI Manager
 
@@ -600,7 +600,6 @@
 	btl_head_init(&btdevs);
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 4, 7)
-	down(&exit_sema);
 	/* start thread here */
 	pid = kernel_thread(mgr_thread, NULL, 0);
 #else
@@ -627,9 +626,6 @@
 {
 	DBFENTER;
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 7)
-	down(&exit_sema);
-#endif
 	if( pid != -1 ) {
 		kill_proc(pid, SIGTERM, 1);
 		down(&exit_sema);
diff -Naur Affix-1_00pre2/kernel/include/affix/bluez.h affix/kernel/include/affix/bluez.h
--- Affix-1_00pre2/kernel/include/affix/bluez.h	Fri May 31 18:23:29 2002
+++ affix/kernel/include/affix/bluez.h	Mon Jun  3 15:17:57 2002
@@ -173,6 +173,8 @@
 		return 0;
 
 	netif_stop_queue(hdev->dev);
+	tasklet_kill(&hdev->tx_task);
+	skb_queue_purge(&hdev->txq);
 	err = hdev->close(hdev);
 
 	return err;

--------------060609070909060403050806--

