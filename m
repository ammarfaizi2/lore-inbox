Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSJVHWJ>; Tue, 22 Oct 2002 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSJVHWJ>; Tue, 22 Oct 2002 03:22:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:50078 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262317AbSJVHWI>; Tue, 22 Oct 2002 03:22:08 -0400
Subject: Re: [PATCH] NMI request/release
From: "Suparna Bhattacharya" <suparna@sparklet.in.ibm.com>
Date: Tue, 22 Oct 2002 17:53:12 +0530
Message-Id: <pan.2002.10.22.17.53.12.332102.2077@sparklet.in.ibm.com>
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk>
X-Comment-To: "John Levon" <levon@movementarian.org>
Pan-Reverse-Path: suparna@sparklet.in.ibm.com
Pan-Mail-To: "John Levon" <levon@movementarian.org>
Pan-Server: ibm-ltc
Organization: IBM
Pan-Attribution: On Tue, 22 Oct 2002 07:46:49 +0530, John Levon wrote:
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002 07:46:49 +0530, John Levon wrote:

> On Mon, Oct 21, 2002 at 08:32:47PM -0500, Corey Minyard wrote:
> 
>> The attached patch implements a way to request to receive an NMI if it
>> comes from an otherwise unknown source.  I needed this for handling
>> NMIs with the IPMI watchdog.  This function was discussed a little a
>> while
> 
> Then NMI watchdog and oprofile should be changed to use this too.


Perhaps even LKCD can make use of such a framework if it works 
out.

 We
> also need priority and/or equivalent of NOTIFY_STOP_MASK so we can break
> out of calling all the handlers. Actually, why do you continue if one of
> the handlers returns 1 anyway ?
> 
>> +	atomic_inc(&calling_nmi_handlers);
> 
> Isn't this going to cause cacheline ping pong ?
> 
>> +	curr = nmi_handler_list;
>> +	while (curr) {
>> +		handled |= curr->handler(curr->dev_id, regs);
> 
> dev_name is never used at all. What is it for ? Also, would be nice to
> do an smp_processor_id() just once and pass that in to prevent multiple
> calls to get_current().
> 
> Couldn't you modify the notifier code to do the xchg()s (though that's
> not available on all CPU types ...)
> 
>> +#define HAVE_NMI_HANDLER	1
> 
> What uses this ?
> 
>> +	volatile struct nmi_handler *next;
> 
> Hmm ...
> 
> Is it not possible to use linux/rcupdate.h for this stuff ?
> 
> regards
> john
