Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267616AbUG3FkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267616AbUG3FkA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 01:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUG3FkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 01:40:00 -0400
Received: from cust.18.243.adsl.cistron.nl ([62.216.18.243]:55713 "EHLO
	nemiahone.tser.org") by vger.kernel.org with ESMTP id S267614AbUG3Fj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 01:39:27 -0400
From: "Reinder" <tser@dwaal.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: --- (or anyone else) one small i2c question. 
Date: Fri, 30 Jul 2004 07:40:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040717152828.3A8FA14DC10A@nemiahone.tser.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
Thread-Index: AcRqC7b2AgRIn299RVWY9iczlyUCugB2PO/gAoR6Y6A=
Message-Id: <20040730063749.B9E5F14DC10A@nemiahone.tser.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, Greg must be on virtual holiday.

Yoo-hoo?

Anyone else, then alive?

I hope open source doesn't mean "Closed community :)"
Here I am. I want to contribute some code. But I need some help, because not
everything can be done alone on this planet. Sometimes you need guidance.

It's better to talk, and send people away on a search, then to ignore
people.

And all I want is some small help with i2c.

Reinder.







-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Reinder
Sent: Saturday, July 17, 2004 16:30
To: linux-kernel@vger.kernel.org
Subject: Greg (or anyone else) one small i2c question. 

Greg,

While having some fun, with the old 2.4 vt8231, ""porting"" that to the 2.6
Branche, my eyes raised some strange question, which I hope you can answer.

>From the Sysf-Interface, it states:

temp[1-4]_max	Temperature max value.
		Unit: Milidegrees Celsius
		Read/Write value.


I far as I know, one Milidegrees is one thousand Grade Celsius.

The actual Reading, from the vt8231 inside the io space is an 8 bit value.
It contains for example a number "78" in "Celsius" for de 1f CPU temp
location.

Now, from various documentations floating around, for some undocumented or
well hidden reason, this mostly is multiplied by 0.88 giving a reading of
68.84

I assume somebody thought about it and calculated that m that was a nice
correction value.

Converting it to the required units, would be 68.84*1000 = 68840
Or, to avoid Floating points: ( (68*1000)*880)/1000 = 68840 Milidegrees
Celsius


That was, when life was easy.

However, my bet is somebody figured out, that bit 7 till 6 in the reserved
area from area 4b, contains also bits of temperature information. (Although
the datasheet I have, describe that area as "Reserved") 

The value is readed, Anded with 192, then shifted to right by 6 to get the
reading.  "0,1,2,3". We assume the value is 3.

Assuming that, this Value is stored in the same Magic Celsius Value,
Multiplied by 880, this gives a correction of 2640 Milidegrees.

That is, if it where separate 8 and 2 bit values. But As I can see, from the
original code, it assumed as 1 10bit value.

Thus the first value 79 is shifted to left by 2, and the second value is
orred into it.  Which gives (79>>2) = 316. 
Plus the low value "3" = 319  

Returning, this, in the old version, to Human readable format, it was
multiplied by 10, and then divided by 4. Giving 797.5

I assume, that something has changed, with the sensor output format.
Thus, the new return formula would be: 
	Multi by 1000, divide by 4.
 Now we have 79750. 



Throwing in the 0.088 Correction Factor the final result is: 
79750* 0.088 = 70180 Milidegrees Celsius

Or 319 * 880 /4 = 70180

Or 319 * 220 = 70180

If this was "temp3" , it would result in 1 sensors.conf line:

Compute temp3 @



Is my final concussing Right? 

If so, I will move on to the voltage part :)
If not, I Hope somebody can point me out where to go...


http://tser.org/vt8231/

		Regards
			Reinder Kraaij.





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

