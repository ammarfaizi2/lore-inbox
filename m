Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbWFPDyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWFPDyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 23:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbWFPDyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 23:54:08 -0400
Received: from smtpout.mac.com ([17.250.248.186]:29650 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751003AbWFPDyH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 23:54:07 -0400
In-Reply-To: <20060614102018.GA22931@merlin.emma.line.org>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com> <193701c68d16$54cac690$0225a8c0@Wednesday> <1150100286.26402.13.camel@tara.firmix.at> <AC44C19E-109F-4DD4-933E-B641BF3BF9CB@mac.com> <17551.21000.94210.883031@cse.unsw.edu.au> <20060614102018.GA22931@merlin.emma.line.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <87A8D21B-5534-4C26-974C-15BFEE16B82A@mac.com>
Cc: Neil Brown <neilb@suse.de>, Bernd Petrovitsch <bernd@firmix.at>,
       David Schwartz <davids@webmaster.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>, jdow <jdow@earthlink.net>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Thu, 15 Jun 2006 23:53:15 -0400
To: Matthias Andree <matthias.andree@gmx.de>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thinking more on this and looking for possible solutions:  One  
(voluntary) technical solution to a mildly technical problem of lack  
of authenticity would be to write a mail server (or just glue postfix  
and apache with some perl CGIs) which stored the emails locally and  
added a header like this:
> X-Hosted-Email:  http://my.mail.server/hosted-email?id=$BASE64_HASH

Then replace the body with this:
> You have received a hosted email from "John Doe"  
> <jdoe@mail.server>.  Click the link below to view the email, or  
> install a free hosted-email client from http:// 
> oss.hosted.email.project/
>
> http://my.mail.server/hosted-email?id=$BASE64_HASH

The templated message might start to get filtered by a few spam- 
filters, but it makes blacklisting of abusers much easier so such  
messages could easily be given a big +bonus in spamassassin or  
similar.  If each compliant server along the way checked that the  
host server was up and provided a compliant SMTP-over-HTTP email it  
would be a trivial load for individual hosts but a quite considerable  
load for spammers.  In addition it's possible to implement other  
checks like wait-for-http-response-before-accepting-email, content  
filters, digital signatures, and other processing steps.  Such a  
system would be very reliable and easy to implement by relying on  
existing proven technologies (SMTP and HTTP) in completely standards- 
compliant ways.  Just some food for thought.

Cheers,
Kyle Moffett
