Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133050AbRDZBob>; Wed, 25 Apr 2001 21:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRDZBoW>; Wed, 25 Apr 2001 21:44:22 -0400
Received: from p0007.as-l042.contactel.cz ([194.108.237.7]:1921 "EHLO
	p0007.as-l042.contactel.cz") by vger.kernel.org with ESMTP
	id <S133050AbRDZBoJ>; Wed, 25 Apr 2001 21:44:09 -0400
Date: Thu, 26 Apr 2001 03:44:41 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Andy Carlson <naclos@swbell.net>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Matrox FB console driver
Message-ID: <20010426034441.M1125@ppc.vc.cvut.cz>
In-Reply-To: <Pine.LNX.4.10.10104232117410.30211-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.20.0104240616170.244-100000@bigandy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.20.0104240616170.244-100000@bigandy>; from naclos@swbell.net on Tue, Apr 24, 2001 at 06:19:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 06:19:31AM -0500, Andy Carlson wrote:
> time prime before x
> real    1m23.535s
> user    0m40.550s
> sys     0m42.980s
> 
> time prime in X
> real    0m42.835s
> user    0m41.180s
> sys     0m1.710s

There can be two reasons:
(1) You are using matrox's mga module. They have
    'program chip core to production level frequency
    instead of bios safe one' in their changelog.
    Although difference 100% makes (2) more probably.
(2) matroxfb does not try to activate any AGP transfer
    mode. Maybe some X driver tries and succeeds.

You can try:

time dd if=/dev/zero of=/dev/fb0 bs=1M count=8

before X and after X. If times are same, then it is
chip core frequency. If times are 2:1, it is either
chip memory freqency, or AGP...
				Petr Vandrovec
				vandrove@vc.cvut.cz

