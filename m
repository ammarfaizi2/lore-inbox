Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264454AbTFKVGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTFKVGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:06:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264454AbTFKVF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:05:57 -0400
Date: Wed, 11 Jun 2003 14:21:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: Messing up driver model API
In-Reply-To: <20030611203652.GA599@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306111407370.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So you just had to mess it up... Having suspend(device *, state,
> level) might be bad, but having suspend(device *, state, level) in one
> piece of code and {suspend,save}(device *, state) is *way* worse. (And
> I did not see any proposal on l-k. I hope I just missed it).

Calm down, Pavel. From a technical standpoint, it's a superior interface. 
Having the 'level' parameter was a mistake made out of speculative 
ignorance - we didn't know exactly how the suspend/resume code was going 
to work, or exactly what we had to do. 

Having explicit calls to save state, power down the device, power on the
deivce and restore state is a Good Thing - it dictates exactly what should
be done at each level. And, it makes more drivers conform to the same
style. Should there be any special cases, then we will deal with them.  
Based on the conversations and the code of the last year, those should be
rare. 

> So are you going to revert it or convert whole driver model to use
> {suspend,save}(device *, state)?

Today: neither. I'm going to see how this works, and if it does, then I 
may convert all the users of struct device_driver to use the same model. 

The interfaces are obvious, and they are documented in the changesets, as 
well as the code. Soon, they will be documented in text files shipped with 
the kernel. I have complete confidence that anyone that takes the time to 
become versed enough in current power management semantics will have no 
problem with the new methods for system devices.


	-pat

