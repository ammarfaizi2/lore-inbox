Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTHSLk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 07:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270321AbTHSLk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 07:40:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:50660 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270291AbTHSLkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 07:40:55 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Tue, 19 Aug 2003 21:40:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16194.3240.192318.806260@gargle.gargle.HOWL>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: message from Vojtech Pavlik on Monday August 18
References: <16188.27810.50931.158166@gargle.gargle.HOWL>
	<20030815094604.B2784@pclin040.win.tue.nl>
	<20030815105802.GA14836@ucw.cz>
	<16188.54799.675256.608570@gargle.gargle.HOWL>
	<20030815135248.GA7315@win.tue.nl>
	<20030815141328.GA16176@ucw.cz>
	<16189.58357.516036.664166@gargle.gargle.HOWL>
	<20030818160138.GA31760@ucw.cz>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday August 18, vojtech@suse.cz wrote:
> 
> How about this patch? It tries to be a bit clever, but hopefully not too
> much ...
> 

Uhmm.. mixed.

It behaved REALLY strangly until I fixed these typoes:

> +				mod_timer(&atkbd->timer,
> +					(test_bit(atkbd->keycode[code], &atkbd->dev.key)
> +						? HZ/30 : HZ/4) + HZ/100);

should be

> +				mod_timer(&atkbd->timer, jiffies + 
> +					(test_bit(atkbd->keycode[code], atkbd->dev.key)
> +						? HZ/30 : HZ/4) + HZ/100);

Then it sort-of worked - my problem keys gave nice up/down
transitions.

However the hardware autorepeat and the software autorepeat seemed to
interfere with each other and auto-repeat was rather erratic.

More of a problem was that control and shift would auto-repeat, and
would often appear to be "up" when I was holding them "down", so
control-X keys strokes were not reliable.

Thanks,
NeilBrown
