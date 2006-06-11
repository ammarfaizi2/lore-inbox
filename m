Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWFKCll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWFKCll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 22:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWFKCll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 22:41:41 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:62943 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1161068AbWFKClk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 22:41:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=YsZO+LXR6DV+MnrjeFsEUIXeRYDuQsDxn+RQhMftOUn6s8p+OrT1WSloXYPb2XhO;
  h=Received:Message-ID:From:To:Cc:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MimeOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <192101c68d00$8c7d0dc0$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "marty fouts" <mf.danger@gmail.com>,
       "David Woodhouse" <dwmw2@infradead.org>
Cc: "Matti Aarnio" <matti.aarnio@zmailer.org>, <linux-kernel@vger.kernel.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org> <1149980791.18635.197.camel@shinybook.infradead.org> <9f7850090606101924r32947e69vb6a34fe905227ff4@mail.gmail.com>
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Date: Sat, 10 Jun 2006 19:41:31 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112053f9d3ecb113dd193de391e1d207029199f37241381ec17c350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.167.175
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "marty fouts" <mf.danger@gmail.com>

> On 6/10/06, David Woodhouse <dwmw2@infradead.org> wrote:
>> On Sun, 2006-06-11 at 01:27 +0300, Matti Aarnio wrote:
>> > Now that there is even an RFC published about SPF...
>>
>> Please, don't do this. SPF makes assumptions about email which are just
>> not true; it rejects perfectly valid mail.
>>
>> http://david.woodhou.se/why-not-spf.html
>>
>> --
>> dwmw2
> 
> I agree.
> 
> Further, while there is an RFC for SPF, it is an RFC for an
> experimental protocol. In addition to what David points out in his web
> site, SPF is controversial, and is in competition with other
> approaches.  (See RFC 4408.)
> 
> It's not widely deployed. It doesn't work. It'll break standard-abiding email.
> 
> Do you really want that?

Rather than inject emotions let's play a little bit with facts. This is
excerpts from a SpamAssassin report for about 82000 emails.

TOP SPAM RULES FIRED
------------------------------------------------------------
RANK    RULE NAME              COUNT %OFRULES %OFMAIL %OFSPAM  %OFHAM
------------------------------------------------------------
  49    SPF_SOFTFAIL           1804     0.42    2.20    8.31    0.01
  72    SPF_HELO_PASS          1112     0.26    1.36    5.13   47.45
  78    SPF_PASS                994     0.23    1.21    4.58   45.53
  92    SPF_HELO_SOFTFAIL       772     0.18    0.94    3.56    0.03
 113    SPF_FAIL                589     0.14    0.72    2.71    0.00
 177    SPF_HELO_FAIL           352     0.08    0.43    1.62    0.00

Stated from the opposite view

TOP HAM RULES FIRED
------------------------------------------------------------
RANK    RULE NAME              COUNT %OFRULES %OFMAIL %OFSPAM  %OFHAM
------------------------------------------------------------
   5    SPF_HELO_PASS          28563     7.20   34.88    5.13   47.45
   6    SPF_PASS               27409     6.90   33.47    4.58   45.53

And so forth.

People here should be smart enough to draw their own conclusions from
raw data.

IMAO, on the whole SPF is not a tool sufficiently good to use as a tool
for rejecting email in and of itself. It is good as a part of a full
anti-spam suite in a half hearted manner. A pass MAY be worthy of a
small negative score for a tool like SpamAssassin. A fail of any kind
is not worth much more than ignoring the fact that it happened. It is
most useful in conjunction with other rejection tools that are based
on identity - typically IP block lists.

As it turns out it has proven quite simple for spammers to get around
with DNS cache poisoning and other techniques. One such trick is a
false DNS record that has an spf record allowing access to the entire
IP world.

Using SPF exclusively is as silly a mugg's game as relying 100% on
the likes of SORBS.

{^_^}   Joanne Dow said that.
