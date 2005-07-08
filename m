Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVGHLAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVGHLAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 07:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVGHLAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 07:00:32 -0400
Received: from hermes2.cs.kuleuven.be ([134.58.40.2]:4530 "EHLO
	hermes2.cs.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S262453AbVGHLA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 07:00:29 -0400
Date: Fri, 8 Jul 2005 12:59:18 +0200 (MEST)
From: Nikolay Pelov <Nikolay.Pelov@cs.kuleuven.ac.be>
To: st3@riseup.net
cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       cpufreq@lists.linux.org.uk
Subject: Re: speedstep-centrino on dothan
In-Reply-To: <20050707235928.71016f61@horst.morte.male>
Message-ID: <Pine.GSO.4.10.10507081247090.7617-100000@bollie.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005 st3@riseup.net wrote:

> 
> int main() {
> unsigned int index, frequency, voltage
> 
> index = (((frequency)/100) << 8) | ((voltage - 700) / 16);
> printf ("%u\n", index);
> }
> 
> frequency is expressed in MHz, voltage in mV, index is the value for
> centrino_model[cpu]->op_points[y].index 

Few days ago I discussed on the cpufreq mailing list that the above formula
is not the correct way to compute the index. Instead of frequency, one
should use a multiplier, i.e.:

  index = (multiplier << 8) | ((voltage - 700) / 16);

and the multiplier is computed as multiplier = frequency/fsb_speed.
On older systems fsb_speed = 100 MHz and that's why the original formula
was working. But for the Sonoma (Centrino 2) Pentium M processors
fsb_speed = 133 MHz. 

To give an example, take a CPU speed of 800MHz and a front side bus of
133MHz. Using the original formula we will use the value

  frequency/100 = 800/100 = 8

which is wrong. The correct value is:

  multiplier = frequency/fsb_speed = 800/133 = 6.

Nikolay

