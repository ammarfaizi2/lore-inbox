Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275843AbRKNR6s>; Wed, 14 Nov 2001 12:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRKNR6i>; Wed, 14 Nov 2001 12:58:38 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:7172 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275843AbRKNR63>;
	Wed, 14 Nov 2001 12:58:29 -0500
Date: Wed, 14 Nov 2001 10:57:17 -0800
From: Greg KH <greg@kroah.com>
To: "Eric S. Raymond" <esr@thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] CML 1.8.4 is available
Message-ID: <20011114105717.D5287@kroah.com>
In-Reply-To: <20011113175010.A15716@thyrsus.com> <20011113182718.A1630@kroah.com> <20011114123325.A500@thyrsus.com> <20011114100020.A5287@kroah.com> <20011114123314.A1978@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011114123314.A1978@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 17 Oct 2001 16:21:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 12:33:14PM -0500, Eric S. Raymond wrote:
> > 
> > CONFIG_HOTPLUG_PCI
> > CONFIG_HOTPLUG_PCI_COMPAQ
> > CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM
> > 
> > See the Config.in file in that directory for the dependencies they have
> > on each other.
> 
> OK, this wiull be in 1.8.6.  I'm going to have to figure out why my coverage 
> tools didn't catch those three symbols.

Thanks.  2.4.15-pre4 didn't allow the user to select these options.  The
attached patch is necessary for them to show up.  Perhaps this is the
reason.

thanks,

greg k-h


diff --minimal -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Mon Nov 12 11:34:30 2001
+++ b/arch/i386/config.in	Mon Nov 12 11:34:30 2001
@@ -234,8 +234,10 @@
 
 if [ "$CONFIG_HOTPLUG" = "y" ] ; then
    source drivers/pcmcia/Config.in
+   source drivers/hotplug/Config.in
 else
    define_bool CONFIG_PCMCIA n
+   define_bool CONFIG_HOTPLUG_PCI n
 fi
 
 bool 'System V IPC' CONFIG_SYSVIPC

