Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289413AbSAJMTD>; Thu, 10 Jan 2002 07:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289417AbSAJMSx>; Thu, 10 Jan 2002 07:18:53 -0500
Received: from nile.gnat.com ([205.232.38.5]:27549 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289413AbSAJMSq>;
	Thu, 10 Jan 2002 07:18:46 -0500
From: dewar@gnat.com
To: Dautrevaux@microprocess.com, dewar@gnat.com, pkoning@equallogic.com
Subject: RE: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, mrs@windriver.com
Message-Id: <20020110121845.91AD8F317E@nile.gnat.com>
Date: Thu, 10 Jan 2002 07:18:45 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Note that this is not too much of a problem for system programming, as you
have a way to be sure they are not combined: just use intermediate variables
and set them separately; the nice thing there is that as you use these
intermediate variables just once, the compiler will eliminate them. But be
careful: the sequence point MUST BE RETAINED, and then the two loads cannot
be combined (in case 1 of course).
>>

Of course we all understand that sequence points myust be retained, but this
is a weak condition compared to the rule that all loads and stores for
volatile variables must not be resequenced, and in particular, you seem to
agree that two loads *can* be combined if they both appear between two
sequence points. I think that's unfortunate, and it is why in Ada we
adopted a stricter point of view that avoids the notion of sequence points.

It even seems that if you have two stores between two sequence points then
the compiler is free to omit one, and again that seems the wrong decision
for the case of volatile variables. If it can omit a store in this way, can
it omit a load, i.e. if we have:

   x := v - v;

can someone read the sequence point rule to mean that the compiler is
free to do only one load here? I hope not, but we have already seen how
much confusion there is on this point.
