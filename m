Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVFCMfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVFCMfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 08:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFCMfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 08:35:55 -0400
Received: from mail1.upco.es ([130.206.70.227]:47539 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261235AbVFCMfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 08:35:39 -0400
Date: Fri, 3 Jun 2005 14:35:36 +0200
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: swsusp, preempt, input and 2.6.12-rc5-mm2 Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Message-ID: <20050603123536.GA13377@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	Andrew Morton <akpm@osdl.org>, pavel@ucw.cz,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050525212520.419ee442.akpm@osdl.org> <20050603094448.GA3218@pern.dea.icai.upco.es> <20050603105010.GA7300@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050603105010.GA7300@pern.dea.icai.upco.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(This last message is copied to linux-kernel too) 

On Fri, Jun 03, 2005 at 12:50:10PM +0200, Romano Giannetti wrote:
> On Fri, Jun 03, 2005 at 11:44:48AM +0200, Romano Giannetti wrote:
> > On Wed, May 25, 2005 at 09:25:20PM -0700, Andrew Morton wrote:

> > > Romano, are you able to tell us whether 2.6.12-rc5 or 2.6.12-rc5-mm1 still
> > > exhibit this hang?
> > 
> > I have tried vanilla 2.6.11-rc5 WITHOUT preempt. swsusp works OK but the
> > acpi keys (suspend, change monitor/LCD) are delayed by 8-hit as explained 
> > in http://bugme.osdl.org/show_bug.cgi?id=4124#c2 
> > 
> > I am compiling 2.6.11-rc5 with preempt now. Then I will do the same on -mm2.
> > Which "style" of preempt should I choose? 
> 
> Tried with vanilla-rc5 and preempt. Good news: now it suspends and resumes,
> with the problem that while resuming I have a lot of "scheduling while
> atomic" and the resume script segfaults (I do not know why, I didn't find
> oops). Reloading the modules and restarting usb manually (i.e., doing
> manually the rest of the script) make it works ok. Sort of, because
> battery module did not see my battery the first time, only the second time I
> load it.) After that, it works ok (it is compiling -mm2 now). 
> 
> On the other end, acpi keys works well, but now doing "acpi -V & acpi -V &
> acpi -V" causes just one of them give the correct battery value, the others
> are very fast but answers with "0%". 

In rc5-mm2, the situation is almost the same. I compiled with PREEMPT, and
the behaviour is very similar to -rc5 vanilla. What changed is, I fear, a
couple of regressions:

 * the laptop did not power off at the end of suspend. It says "calling acpi
 poweroff" and stay there forever. Nevertheless, then it resumes "well" (as
 well as vanilla -rc5, I mean, with the same problems, see above). 

 * now the acpi battery loaded "wrong" at boot, too. I tried several way:
 the first time battery is not detected, rmmod it, modprobe it again and it
 is detected. acpi -V & acpi -V has the same problem.

 * last but not least: the laptop did a hissing sound that 2.6.11 did not
 show, and tje mouse pointer was "trembling" (horizontally) on his own.
 Maybe this is an effect of choosing 250 Hz tick? 

All data (config, dmesg, etc) is available on the web. After boot, after
boot and rmmod battery/modprobe battery, after resume and after resume and
manual issuing of modprobe battery/rrmod battery/modprobe battery etc are
here: 

http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-mm2-afterboot/laptop-config.html
http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-mm2-afterboot-modprobebattery/laptop-config.html
http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-mm2-afterresume/laptop-config.html
http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-mm2-afterresumeandmodprobe/laptop-config.html

I will have a bit more of time next week, so please tell me if I can help
you with all of this of give more info. I can manage to set up a serial
console, if it's needed. 

         Thanks, Romano
         
PD following info is for vanilla -rc5

> 
> All info (after boot, after resume, after having manually restarted battery
> etc and usb) in:
> 
> http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-preempt-afterboot/laptop-config.html
> http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-preempt-afterresume/laptop-config.html
> http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-preempt-afterresume-and-modprobe/laptop-config.html
> 
> > PD: I have not applied the patch suggested there, because it causes the
> > problem that two concurrent "read" of the battery fails (I mean: in vanilla
> > 2.6.11-rc5 doing "acpi -V & acpi -V" give two times the same value, but with
> > the patch
> > http://www.dea.icai.upco.es/romano/linux/vaio-conf/patch-no3851.id4516 it
> > gives a correct ouptput and the second one, running much faster, give 0% for
> > the battery charge. 
> 
> Well. the excat same thing occurs (as I said above) without the patch and
> with preempt. 
> 
> Will report -mm2 behaviour later. 
> 
> Hope this helps,
> 
>                   Romano
>                   
> -- 
> Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
> Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
