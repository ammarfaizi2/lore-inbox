Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757802AbWK0LKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757802AbWK0LKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758039AbWK0LKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:10:38 -0500
Received: from ns.suse.de ([195.135.220.2]:17332 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1757802AbWK0LKh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:10:37 -0500
To: "Cestonaro, Thilo (external)" 
	<Thilo.Cestonaro.external@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird wasting of time between ioctl() and ioctl dispatcher
References: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5863@ABGEX01E.abg.fsc.net>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2006 12:10:33 +0100
In-Reply-To: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5863@ABGEX01E.abg.fsc.net>
Message-ID: <p73r6vpdu1i.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Cestonaro, Thilo \(external\)"    <Thilo.Cestonaro.external@fujitsu-siemens.com> writes:

> I'm a developer for Fujitsu Siemens Computers, working on a program which has it's own kernel modules and userland components.
> Now cause the program should be released we have done some testing and during this testphase a wierd wasting of time occured
> during the call of the ioctl() in the userland component and the actuall entering of the dispatcher function in the module.
> It takes 3 min. until the call at last enters my dispatcher. 

Something else is holding the big kernel lock for that long. Most likely
it's your own code. Consider using a ->unlocked_ioctl

-Andi
