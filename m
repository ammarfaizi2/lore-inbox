Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275734AbRI0CQq>; Wed, 26 Sep 2001 22:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275735AbRI0CQh>; Wed, 26 Sep 2001 22:16:37 -0400
Received: from rj.sgi.com ([204.94.215.100]:37321 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S275734AbRI0CQa>;
	Wed, 26 Sep 2001 22:16:30 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Torri <storri@ameritech.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.9-ac15 (double entries for DRI cards) 
In-Reply-To: Your message of "Wed, 26 Sep 2001 13:48:26 -0400."
             <Pine.LNX.4.33.0109261340560.1820-100000@base.torri.linux> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Sep 2001 12:16:42 +1000
Message-ID: <8203.1001557002@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2001 13:48:26 -0400 (EDT), 
Stephen Torri <storri@ameritech.net> wrote:
>In "Character Devices" when configuring the kernel using xconfig there are
>double entries for video cards under Direct Rendering Manager.  The
>following cards are reported twice:
>
>3dfx Banshee/Voodoo3+
>3dlabs GMX 2000
>ATI Rage 128
>ATI Radeon
>Intel I810
>Matrox G200/G400/G450
>
>They menu is correct when doing menuconfig. They are only reported once.

That is normal with xconfig, it displays all possible options and greys
out the ones that you cannot select.  Trivial patch to make it more
obvious what is going on, against 2.4.9-ac15.

Index: 9.42/drivers/char/Config.in
--- 9.42/drivers/char/Config.in Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/b/c/3_Config.in 1.2.1.1.4.3.1.5 644)
+++ 9.42(w)/drivers/char/Config.in Thu, 27 Sep 2001 12:11:54 +1000 kaos (linux-2.4/b/c/3_Config.in 1.2.1.1.4.3.1.5 644)
@@ -219,8 +219,10 @@ bool 'Direct Rendering Manager (XFree86 
 if [ "$CONFIG_DRM" = "y" ]; then
    bool '  Build drivers for new (XFree 4.1) DRM' CONFIG_DRM_NEW
    if [ "$CONFIG_DRM_NEW" = "y" ]; then
+      comment 'DRM 4.1 drivers'
       source drivers/char/drm/Config.in
    else
+      comment 'DRM 4.0 drivers'
       define_bool CONFIG_DRM_OLD y
       source drivers/char/drm-4.0/Config.in
    fi

