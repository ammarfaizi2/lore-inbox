Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUGQO3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUGQO3x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 10:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUGQO3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 10:29:53 -0400
Received: from cust.18.243.adsl.cistron.nl ([62.216.18.243]:28800 "EHLO
	nemiahone.tser.org") by vger.kernel.org with ESMTP id S266124AbUGQO3t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 10:29:49 -0400
From: "Reinder" <tser@dwaal.net>
To: <linux-kernel@vger.kernel.org>
Subject: Greg (or anyone else) one small i2c question. 
Date: Sat, 17 Jul 2004 16:30:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRqC7b2AgRIn299RVWY9iczlyUCugB2PO/g
In-Reply-To: <20040715000527.GA18923@kroah.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.181
Message-Id: <20040717152828.3A8FA14DC10A@nemiahone.tser.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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





