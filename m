Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282076AbRLCIvj>; Mon, 3 Dec 2001 03:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284468AbRLCIuc>; Mon, 3 Dec 2001 03:50:32 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:57359 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284358AbRLBW6H>;
	Sun, 2 Dec 2001 17:58:07 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs 
In-Reply-To: Your message of "Sun, 02 Dec 2001 11:59:34 CDT."
             <Pine.GSO.4.21.0112021150310.12801-100000@binet.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Dec 2001 09:57:46 +1100
Message-ID: <29283.1007333866@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001 11:59:34 -0500 (EST), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Sun, 2 Dec 2001, Pierre Rousselet wrote:
>
>> Here is the final (i hope) verdict of my devfs testbox :
>> 
>> 2.4.16 with devfsd-1.3.18/1.3.20 : OK
>> 2.4.17-pre1         "            : Broken
>> 2.5.1-pre1          "            : OK
>> 2.5.1-pre2 with or without v200  : Broken
>> 2.5.1-pre5          "            : Broken
>
>IOW, merge of new devfs code (2.4.17-pre1 in -STABLE, 2.5.1-pre2 in -CURRENT).
>
>We really need CONFIG_DEBUG_* forced if CONFIG_DEVFS_FS is set.  Otherwise
>we'll be getting tons of bug reports due to silent memory corruption.
>
>Keith, is there a decent way to do that?  For 2.4.17 it would help a lot...

Against 2.4.17-pre2, untested.  Revert before 2.4.17.

Index: 17-pre2.1/fs/Config.in
--- 17-pre2.1/fs/Config.in Tue, 13 Nov 2001 08:45:38 +1100 kaos (linux-2.4/m/b/39_Config.in 1.2.1.2.1.7 644)
+++ 17-pre2.1(w)/fs/Config.in Mon, 03 Dec 2001 09:54:58 +1100 kaos (linux-2.4/m/b/39_Config.in 1.2.1.2.1.7 644)
@@ -63,7 +63,10 @@ bool '/proc file system support' CONFIG_
 
 dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
 dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
-dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
+if [ "$CONFIG_DEVFS_FS" = "y" ] ; then \
+   define_bool CONFIG_DEVFS_DEBUG y
+fi
+# dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
 
 # It compiles as a module for testing only.  It should not be used
 # as a module in general.  If we make this "tristate", a bunch of people

