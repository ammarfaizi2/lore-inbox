Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbULPO21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbULPO21 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 09:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbULPO1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 09:27:22 -0500
Received: from bigeats.dufftech.com ([69.57.156.29]:20638 "HELO
	bigeats.dufftech.com") by vger.kernel.org with SMTP id S262688AbULPOZC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 09:25:02 -0500
In-Reply-To: <20041215190725.GA24635@delft.aura.cs.cmu.edu>
References: <1103038728.10965.12.camel@sucka> <Pine.LNX.4.61.0412141700430.24308@yvahk01.tjqt.qr> <1103042538.10965.27.camel@sucka> <Pine.LNX.4.61.0412141742590.22148@yvahk01.tjqt.qr> <1103043716.10965.40.camel@sucka> <8AF1BC56-4E1C-11D9-B94B-000393ACC76E@mac.com> <57782EC8-4E40-11D9-B971-003065B11AE8@dberg.org> <20F668EE-4E48-11D9-B94B-000393ACC76E@mac.com> <1103120162.5517.14.camel@sucka> <20041215190725.GA24635@delft.aura.cs.cmu.edu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <444EB40D-4F6E-11D9-91A1-003065B11AE8@dberg.org>
Content-Transfer-Encoding: 7bit
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>
From: Adam Denenberg <adam@dberg.org>
Subject: Re: bind() udp behavior 2.6.8.1
Date: Thu, 16 Dec 2004 09:24:59 -0500
To: Jan Harkes <jaharkes@cs.cmu.edu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I disagree.  The linux server should be using unique Transaction ID's 
in the dns header for each unique dns request.  Otherwise there is no 
way to distinguish them (same A record request).  Of course the 
firewall is going to drop a reply that it thinks it already saw a reply 
for 30ms ago.

This appears to be a bug in the way glibc is handling things but i 
cannot be sure.  That is the goal of my investigation.

adam

Please CC me i am not on the list.

On Dec 15, 2004, at 2:07 PM, Jan Harkes wrote:

> On Wed, Dec 15, 2004 at 09:16:02AM -0500, Adam Denenberg wrote:
>> the Firewall from distinguishing unique dns requests.  It sees a 
>> second
>> DNS request come from the linux server with the _same_ transaction ID 
>> in
>> the UDP header as it is marking that session closed since it already 
>> saw
>> the reply successfully.  So for example the linux server is making a 
>> dns
>
> Stupid guess here,
>
> The reply got dropped after it passed your firewall and before it
> reached the linux server. What you are seeing is simply a retransmit
> which would also have happened if the original request got lost, or if
> the reply was dropped before it reached your firewall, in which case 
> the
> firewall probably would have forwarded the retransmitted request 
> without
> a problem.
>
> I would open the window before you throw the piece of garbage out.
>
> Jan
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

