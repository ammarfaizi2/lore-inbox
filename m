Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319388AbSH2WXa>; Thu, 29 Aug 2002 18:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSH2WWd>; Thu, 29 Aug 2002 18:22:33 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.18.111]:46088 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S319388AbSH2WWS>; Thu, 29 Aug 2002 18:22:18 -0400
Date: Fri, 30 Aug 2002 00:26:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: input u-cleanup
Message-ID: <20020829222642.GB16986@atrey.karlin.mff.cuni.cz>
References: <20020828220603.GA30107@elf.ucw.cz> <20020829081736.A23935@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020829081736.A23935@ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > proc is clever enough not to need ifdefs, so this is probably good
> > idea...
> > 
> > 								Pavel
> 
> If you could remove all the procfs #ifdefs from input.c, that'd be great.
> But removing only those around unregistration IMHO doesn't make
> > sense.


They can be safely dropped. I had patch to do that but droped it during
merge. If you'll accept complete patch, I'll create it.   [Or you can
do it yourself, just killing #ifdef CONFIG_PROC_FS should do the
trick].

 
> > 
> > --- clean/drivers/input/input.c	Wed Aug 28 22:38:46 2002
> > +++ linux-swsusp/drivers/input/input.c	Wed Aug 28 23:28:23 2002
> > @@ -800,11 +803,9 @@
> >  
> >  static void __exit input_exit(void)
> >  {
> > -#ifdef CONFIG_PROC_FS
> >  	remove_proc_entry("devices", proc_bus_input_dir);
> >  	remove_proc_entry("handlers", proc_bus_input_dir);
> >  	remove_proc_entry("input", proc_bus);
> > -#endif
> >  	devfs_unregister(input_devfs_handle);
> >          if (unregister_chrdev(INPUT_MAJOR, "input"))
> >                  printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);
> > 
> > -- 
> > Worst form of spam? Adding advertisment signatures ala sourceforge.net.
> > What goes next? Inserting advertisment *into* email?
> 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
