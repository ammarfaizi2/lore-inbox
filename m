Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271905AbRIDIKt>; Tue, 4 Sep 2001 04:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271907AbRIDIKi>; Tue, 4 Sep 2001 04:10:38 -0400
Received: from [195.66.192.167] ([195.66.192.167]:43525 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271905AbRIDIKW>; Tue, 4 Sep 2001 04:10:22 -0400
Date: Tue, 4 Sep 2001 11:08:52 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1849062961.20010904110852@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200109032035.NAA01597@happy.xkey.com>
In-Reply-To: <200109032035.NAA01597@happy.xkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, September 03, 2001, 11:35:52 PM, David desJardins
<david@desjardins.org> wrote:

Dd> The explicit typing of MIN and MAX will avoid some bugs that have to do
Dd> with the comparison of entities of different types.  The explicit typing
Dd> will also introduce some bugs, when a user uses the wrong type (e.g.,
Dd> when the code is initially written with the correct type, but then
Dd> someone later changes the type of the variables, and doesn't remember to
Dd> change the type in the macro call).  Overall, I think it will be about a
Dd> wash.
...
Dd> I think the best approach to bug avoidance would be two-argument MIN and
Dd> MAX functions which require that both arguments have the same type, but
Dd> where that can be any type.  Then users who want to compare objects of
Dd> different types would have to explicitly cast one to the type of the
Dd> other (or both to a third common type).  In the most common case where
Dd> users are simply comparing objects of the same type, there would be no
Dd> need or reason to change the code.

This sounds right!

#define min2(a,b)      ...  <-- checks for a,b being the same type
#define min3(type,a,b) ...  <-- casts a,b to type first

min3(long long,a,b) will be a favorite in bug chasing :-)

Dd> It's simple enough for an external checker to confirm that this rule is
Dd> followed.  The same checker could enforce the same rule for "<" and
Dd> other comparison operators, which would probably help eliminate several
Dd> bugs (without the unacceptably clunky LESSTHAN macro).

Good candidate for Stanford checker, but there will be lots of false
positives.
-- 
Best regards,
VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


