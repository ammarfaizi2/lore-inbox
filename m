Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289750AbSAWJnw>; Wed, 23 Jan 2002 04:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSAWJnm>; Wed, 23 Jan 2002 04:43:42 -0500
Received: from [62.245.135.174] ([62.245.135.174]:40894 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S289750AbSAWJna>;
	Wed, 23 Jan 2002 04:43:30 -0500
Message-ID: <3C4E85BB.FBC5C2E4@TeraPort.de>
Date: Wed, 23 Jan 2002 10:43:23 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Reply-To: m.knoblauch@TeraPort.de
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-pre4-J0-VM-22-preempt-lock i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible Idea with filesystem buffering.
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/23/2002 10:43:23 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 01/23/2002 10:43:29 AM,
	Serialize complete at 01/23/2002 10:43:29 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: Possible Idea with filesystem buffering.
> 
> From: Richard B. Johnson (root@chaos.analogic.com)
> Date: Tue Jan 22 2002 - 17:10:27 EST
>  
> 
> We need a free-RAM target, possibly based upon a percentage of
> available RAM. The lack of such a target is what causes the
> out-of-RAM condition we have been experiencing. Somebody thought
> that "free RAM is wasted RAM" and the VM has been based upon
> that theory. That theory has been proven incorrect. You need

 Now, I think the theory itself is OK. The problem is that the stuff in
buffer/caches is to sticky. It does not go away when "more important"
uses for memory come up. Or at least it does not go away fast enough.

> free RAM, just like you need "excess horsepower" to make
> automobiles drivable. That free RAM is the needed "rubber-band"
> to absorb the dynamics of real-world systems.
>

 Correct. The free target would help to avoid the panic/frenzy that
breaks out when we run out of free memory.

 Question: what about just setting a maximum limit to the cache/buffer
size. Either absolute, or as a fraction of total available memory? Sure,
it maybe a waste of memory in most situations, but sometimes the
administrator/user of a system simply "knows better" than the FVM (F ==
Fine ? :-)

 While being there, one could also add a "guaranteed minimum" limit for
the cache/buffer size. This way preventing a complete meltdown of IO
performance. True64 has such limits. They are usually at 100% (max) and
I think 20% (min), giving the cache access to all memory. But there were
situations where a max of 10% was just the rigth thing to do.

 I know, the tuning-knob approach is frowned upon. But sometimes there
are workloads where even the best VM may not know how to react
correctly.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
