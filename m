Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVDYUYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVDYUYo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVDYUYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:24:32 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:12737 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261161AbVDYUW3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:22:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cLgRePGXE1Q1ke3qPPK36toXXlDSNCzIBHdrJR9bNHh/Pc0MmubZyPoJ8RQT8iiZy0PcHsmZB3lgpzUh16cHeHGwEtYeyFtRCD5QaTAnIxCgfjz8ylTw4A55BPJ/LzeLSubpNuPI4HrcDi6NURSDBvC1aqlTvgPFHJ6AoM7JQ1o=
Message-ID: <d120d500050425132250916bcb@mail.gmail.com>
Date: Mon, 25 Apr 2005 15:22:29 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: johnpol@2ka.mipt.ru
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
	 <1114420131.8527.52.camel@uganda>
	 <d120d50005042509326241a302@mail.gmail.com>
	 <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> While thinking about locking schema
> with respect to sysfs files I recalled,
> why I implemented such a logic -
> now one can _always_ remove _any_ module
> [corresponding object is removed from accessible
> pathes and waits untill all exsting users are gone],
> which is very good - I really like it in networking model,
> while with whole device driver model
> if we will read device's file very quickly
> in several threads we may end up not unloading it at all.

I am sorrry, that is complete bull*. sysfs also allows removing
modules at an arbitrary time (and usually without annoying "waiting
for refcount" at that)... You just seem to not understand how driver
code works, thus the need of inventing your own schema.

BTW, I am looking at the connector code ATM and I am just amazed at
all wied refounting stuff that is going on there. what a single
actomic_dec_and_test() call without checkng reurn vaue is supposed to
do again?

-- 
Dmitry
