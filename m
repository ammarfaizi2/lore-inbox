Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVAKQ6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVAKQ6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVAKQ5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:57:10 -0500
Received: from [82.147.40.124] ([82.147.40.124]:20865 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S262843AbVAKQp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:45:28 -0500
Subject: Re: i2c_adapter i2c-0: Bus collision!
From: Stian Jordet <liste@jordet.nu>
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
In-Reply-To: <20040117094856.2f8b44c8.khali@linux-fr.org>
References: <1073527236.624.7.camel@buick> <1073707567.621.5.camel@buick>
	 <1074304828.780.2.camel@chevrolet.hybel>
	 <20040117094856.2f8b44c8.khali@linux-fr.org>
Content-Type: text/plain; charset=iso-8859-1
Date: Tue, 11 Jan 2005 17:44:55 +0100
Message-Id: <1105461895.8299.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

about a year ago I asked for help with my motherboard, claiming i2c bus
collisions all the time. Now I found the solution, the sensor uses the
isa bus, not the i2c. Funny it sometimes worked with i2c-viapro, but
with i2c-isa it works all the time :)

Sorry for not finding that out earlier.

Best regards,
Stian

lør, 17,.01.2004 kl. 09.48 +0100, skrev Jean Delvare:
> > sorry to bother you again, but this didn't tell you anything about
> > what's going on?
> 
> Sorry for the delay. Too much work, not enough time. You know the story
> I guess.
> 
> > > I forgot to mention it in my last mail, but I sometime has to
> > > reload the modules before "sensors" finds any sensor.
> 
> As we load sensor chip drivers, we make sure that the chip we want to
> handle is what we think it is. Technically, this means reading from a
> few registers and compare the values with what we would expect for this
> chip. So the same read errors that make your hardware monitoring values
> jump make the chip identification fail sometimes.
> 
> > > Attached three runs. Seems to be some read errors :( On these three
> > > runs I got first three bus-collisions, then one, and last two.
> 
> Not all read errors are detected as bus collisions. Anyway, you got
> loads of 'XX' as I expected, "moving" from run to run, which means that
> your i2c bus is unreliable.
> 
> My conclusion would be: bad hardware design generates noise on the i2c
> bus, resulting in read errors.
> 
> > > > Did you have to enable any particular option in MBM?
> > > 
> > > Nah, it just worked :)

> I asked Alex van Kaam (MBM's brilliant author) about his strategy with
> bus collisions. To make it short, he explained he resets the bus on
> problems. If you confirm that the smbus MBM detected was Via, Alex will
> send me his code so that I can compare with ours, just in case. But I
> doubt it'll change anything (our driver is working, it's just a matter
> of how errors are - or aren't - handled).
> 
> Basically we don't handle read errors at all (because it is so rare).
> Handling them correctly would make all chip drivers (and possibly i2c
> core and bus drivers as well) more complex. I'm not sure it's worth it.
> 
> That said, a similar problem was reported with W83L785TS-S chips (A7N8X
> motherboards). I think that the cause is different (BIOS trying to
> access the bus at the same time we do) but the consequences are the
> same. I plan to add basic error handling to this specific chip driver
> (don't know when I'll find the time to do so though). If it works and
> could be extended to other drivers as well, we'll consider it.
> 
> > > I guess this is unsolvable, but I just wanted to hear what you say.
> > > Kinda weird it works so well with MBM, but that's ok. It's just for
> > > fun I want it to work.
> 
> I think it is work-around-able, but doubt it's worth it. Anyway, thanks
> for reporting, as it increased our knowledge of the topic.
> 
> > > Thanks for your reply :)
> 
> You're welcome. Sorry for the delay again.
> 

