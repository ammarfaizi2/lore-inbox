Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUCVKF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 05:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUCVKF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 05:05:59 -0500
Received: from mail1.upco.es ([130.206.70.227]:54227 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261862AbUCVKF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 05:05:27 -0500
Date: Mon, 22 Mar 2004 11:05:21 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: Romano Giannetti <romano@pern.dea.icai.upco.es>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: swsusp 2.0 with kernel 2.6.4, failure to suspend (vaio fx701)
Message-ID: <20040322100521.GA26767@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, hi Nigel,

   as promised I tried swsusp2 with my vaio. Here is my report: 

Ok,
     I tried swsup2 with kernel 2.6.4. Maybe I have made something
     incorrect, so I will simply report what happened to me. 
     
   * I have a Sony FX701 laptop; Mandrake 9.2 with upgrades, with
     working 2.6.4 kernel. It works (in the sense that it will suspend
     correctly) with in-kernel swsusp and pmdisk. 
     
   * To test swsusp2, I did the following: 
     - patched a vanilla kernel with (in the order):
              software-suspend-linux-2.6.4-test3-whole.bz2
              software-suspend-core-2.0-whole.bz2*
              software-suspend-core-2.0.0.22-incremental.bz2*
     Configured and installed; .config and lilo.conf available here: 
     http://perso.wanadoo.es/r_mano/vaio/suspend/dot_config.zip
     http://perso.wanadoo.es/r_mano/vaio/suspend/lilo.conf.zip
     
   * Then I used my suspend script, with  the only change of 
          echo yes > /proc/swsusp/activate
     instead of 
          echo 4 > /proc/acpi/sleep
     (script is rg_sw2_script) 
     http://perso.wanadoo.es/r_mano/vaio/suspend/rg_sw2_script
     
   * The result is:
     - the laptop switch to text console
     - a screen says "waiting to activities to finish" 
     - I waited 5 minutes, but nothing happened - the "status bar" would not
       move. 
     Pressing ESC at this point, the laptop comes back to its normal working
     condition, with the task dump included in the file 
     failed_suspend1.txt.gz.
     http://perso.wanadoo.es/r_mano/vaio/suspend/failed_suspend1.txt.zip     
   
    * I rebooted (to have a fresh start) and repeated with swsusp2
    debug_level set to 9, log_everything to yes, like this:
    # echo 9 > /proc/swsusp/default_console_level
    # echo yes > /proc/swsusp/log_everything
    # echo yes > /proc/swsusp/beeping
    # echo yes > /proc/swsusp/slow
    and what I obtained is a very similar behaviour, see it in
    failed_suspend2.txt.gz. Now during suspend a few traces were printed (I
    am not sure they have been logged, they scrolled really fast) then a
    series of lines told "swsusp_num_active is 4, Idle for 250 jiffies"
    scrolled away, more or less one or two per second. Pressing ESC will 
    resume the laptop. 
    http://perso.wanadoo.es/r_mano/vaio/suspend/failed_suspend2.txt.zip
      
Conclusion: swsusp2 does not work for me, but probably it's a trivial
problem... There is something that would not freeze. 
I am available to give more info on request and try more things.


Romano

   
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
