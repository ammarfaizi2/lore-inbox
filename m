Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264638AbRFYPko>; Mon, 25 Jun 2001 11:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbRFYPke>; Mon, 25 Jun 2001 11:40:34 -0400
Received: from sncgw.nai.com ([161.69.248.229]:53667 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S264638AbRFYPkU>;
	Mon, 25 Jun 2001 11:40:20 -0400
Message-ID: <XFMail.20010625084330.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3B36BC65.FF27BBB1@kegel.com>
Date: Mon, 25 Jun 2001 08:43:30 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Dan Kegel <dank@kegel.com>
Subject: Re: Collapsing RT signals ...
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Jun-2001 Dan Kegel wrote:
> Davide Libenzi <davidel@xmailserver.org> wrote:
>> I'm making some test with RT signals and looking at how they're implemented
>> inside the kernel.
>> After having experienced frequent queue overflow signals I looked at how
>> signals are queued inside the task_struct.
>> There's no signals optimization inside and this make the queue length
>> depending
>> on the request rate instead of the number of connections.
>> It can happen that two ( or more ) POLL_IN signals are queued with a single
>> read() that sweep the buffer leaving other signals to issue reads ( read
>> this
>> as user-mode / kernel-mode switch ) that will fail due lack of data.
>> So for every "superfluous" signal we'll have two user-mode / kernel-mode
>> switches, one for signal delivery and one for a failing read().
>> I'm just thinking at a way to optimize the signal delivery that is ( draft )
>> :
>> ...
> 
> I agree, the queue overflow case is a pain in the butt.
> 
> Before you get too far coding up your idea, have you read
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99023775430848&w=2

Double thank You Dan, they did exactly what I want to do :)




- Davide

