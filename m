Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287314AbSAGW0X>; Mon, 7 Jan 2002 17:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287310AbSAGW0O>; Mon, 7 Jan 2002 17:26:14 -0500
Received: from gate.tuxia.com ([213.209.134.221]:16623 "EHLO
	exchange1.win.agb.tuxia") by vger.kernel.org with ESMTP
	id <S287306AbSAGW0D> convert rfc822-to-8bit; Mon, 7 Jan 2002 17:26:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] C undefined behavior fix
Date: Mon, 7 Jan 2002 23:26:01 +0100
Message-ID: <A16915712C18BD4EBD97897F82DA08CD7E7D6C@exchange1.win.agb.tuxia>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] C undefined behavior fix
Thread-Index: AcGXyUHTnfPALv5+TQi8G09METaFZQAABiNA
From: "Tim McDaniel" <tim.mcdaniel@tuxia.com>
To: "jtv" <jtv@xs4all.nl>, "Tim Hollebeek" <tim@hollebeek.com>
Cc: "Bernard Dautrevaux" <Dautrevaux@microprocess.com>, <dewar@gnat.com>,
        <paulus@samba.org>, <gcc@gcc.gnu.org>, <linux-kernel@vger.kernel.org>,
        <trini@kernel.crashing.org>, <velco@fadata.bg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: jtv [mailto:jtv@xs4all.nl]
Sent: Monday, January 07, 2002 4:16 PM
To: Tim Hollebeek
Cc: Bernard Dautrevaux; 'dewar@gnat.com'; paulus@samba.org;
gcc@gcc.gnu.org; linux-kernel@vger.kernel.org;
trini@kernel.crashing.org; velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix


On Mon, Jan 07, 2002 at 05:28:32PM -0500, Tim Hollebeek wrote:
> 
> You're not allowed to be that smart wrt volatile.  If the programmer
> says the value might change unpredictably and should not be optimized,
> then It Is So and the compiler must respect that even if it determines
> It Cannot Possibly Happen.

Naturally I hope you're right.  But how does that follow from the
Standard?
I have to admit I don't have a copy handy.  :(

Let's say we have this simplified version of the problem:

	int a = 3;
	{
		volatile int b = 10;
		a += b;
	}

Is there really language in the Standard preventing the compiler from
constant-folding this code to "int a = 13;"?




Jeroen


In the above case it is unlikely that folding would present a problem,
but volatile was created because hardware, or even seemingly unrelated
software, can modify even the most unlikely memory locations.   If you
want to break device drivers, go ahead and optimize your compiler.  



 

Tim

The only thing dummer than a cow is a man who thinks he's smarter than a
cow.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
