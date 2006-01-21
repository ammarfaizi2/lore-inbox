Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030330AbWAUCBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030330AbWAUCBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWAUCBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:01:55 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:35058 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030330AbWAUCBy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:01:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sFsJmcA5Z7qYIhyZwZ47EUEv6YqiyIlQ3TAWhqgcijMkmuTuarYQ4yEGkOysZ5RfJwEgSvMxrG6qumh22biV8Tm7wCS8e48kwQiCDqVv9oLPaY5c9ZRnpYNvnLd9qab0PDbEJK+q9/HrLU8bUfA8Bx2Q2QSuP1LWQ7ZaQbXtSN8=
Message-ID: <56a8daef0601201801s6f8c3b79xcc06aaacc430309d@mail.gmail.com>
Date: Fri, 20 Jan 2006 18:01:53 -0800
From: John Ronciak <john.ronciak@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: My vote against eepro* removal
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, kus Kusche Klaus <kus@keba.com>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       jesse.brandeburg@intel.com, netdev@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1137807048.3241.58.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <AAD6DA242BC63C488511C611BD51F367323324@MAILIT.keba.co.at>
	 <20060120095548.GA16000@2ka.mipt.ru>
	 <1137804050.3241.32.camel@mindpipe>
	 <56a8daef0601201719t448a6177lfebabe3ca38a00c7@mail.gmail.com>
	 <1137807048.3241.58.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
>
> Why don't these cause excessive scheduling delays in eepro100 then?
> Can't we just copy the eepro100 behavior?
Reports still float around from time to time about hangs with the
eepro100 which go away when the e100 driver is used.  We don't
maintain the eepro100 driver so I can't tell you much about it other
than the reports we get sometimes.

There is a timer routine in the eepro100 driver which does the check
for link as well as a check for on of the hang conditions (with
work-around).  It does the check for link in a different way than
e100.  e100 uses mii call where eepro100 does it manually.  Another
difference is that eepro100 doesn't get stats unless called by the
system.  It's not in the timer routine at all.

Can we try a couple of things? 1) just comment out all the check for
link code in the e100 driver and give that a try and 2) just comment
out the update stats call and see if that works.  These seem to be the
differences and we need to know which one is causing the problem.


--
Cheers,
John
