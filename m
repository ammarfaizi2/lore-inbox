Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbTHSX76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbTHSX76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:59:58 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:21191 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261547AbTHSX7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:59:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Wed, 20 Aug 2003 09:59:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16194.47588.337951.358727@gargle.gargle.HOWL>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: message from Vojtech Pavlik on Tuesday August 19
References: <16188.27810.50931.158166@gargle.gargle.HOWL>
	<20030815094604.B2784@pclin040.win.tue.nl>
	<20030815105802.GA14836@ucw.cz>
	<16188.54799.675256.608570@gargle.gargle.HOWL>
	<20030815135248.GA7315@win.tue.nl>
	<20030815141328.GA16176@ucw.cz>
	<16189.58357.516036.664166@gargle.gargle.HOWL>
	<20030818160138.GA31760@ucw.cz>
	<16194.3240.192318.806260@gargle.gargle.HOWL>
	<20030819115014.GA5403@ucw.cz>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday August 19, vojtech@suse.cz wrote:
> > It behaved REALLY strangly until I fixed these typoes:
> > 
> > > +				mod_timer(&atkbd->timer,
> > > +					(test_bit(atkbd->keycode[code], &atkbd->dev.key)
> > > +						? HZ/30 : HZ/4) + HZ/100);
> > 
> > should be
> > 
> > > +				mod_timer(&atkbd->timer, jiffies + 
> > > +					(test_bit(atkbd->keycode[code], atkbd->dev.key)
> > > +						? HZ/30 : HZ/4) + HZ/100);
> 
> Thanks for spotting that! I originally had "!test_bit" there, and then
> removed the ! and forgot to swap the conditional values.

I swapped the "30" and the "4", it is is better still.  Auto-repeat of
normal keys is ok (I think - didn't test extensively).
control/shift is still a problem, though not quite as a bad

When I hold right-control down, evtest shows:

Event: time 1061335715.975639, type 1 (Key), code 97 (RightCtrl), value 1
Event: time 1061335715.975639, -------------- Config Sync ------------
Event: time 1061335716.014658, type 1 (Key), code 97 (RightCtrl), value 0
Event: time 1061335716.014659, -------------- Config Sync ------------
Event: time 1061335716.485899, type 1 (Key), code 97 (RightCtrl), value 1
Event: time 1061335716.485899, -------------- Config Sync ------------
Event: time 1061335716.734535, type 1 (Key), code 97 (RightCtrl), value 2
Event: time 1061335716.734536, -------------- Config Sync ------------
Event: time 1061335716.764555, type 1 (Key), code 97 (RightCtrl), value 2
Event: time 1061335716.764556, -------------- Config Sync ------------

so if I type another char between 30ms and 500ms after pressing
control, the control isn't noticed, else it is.

NeilBrown
