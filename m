Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAESnK>; Fri, 5 Jan 2001 13:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAESnA>; Fri, 5 Jan 2001 13:43:00 -0500
Received: from open.your.mind.be ([195.162.205.66]:63478 "HELO
	portablue.intern.mind.be") by vger.kernel.org with SMTP
	id <S129183AbRAESmu>; Fri, 5 Jan 2001 13:42:50 -0500
Date: Fri, 5 Jan 2001 19:42:02 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tulip driver
Message-ID: <20010105194202.A1831@mind.be>
Mail-Followup-To: p2@mind.be, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
From: p2@mind.be (Peter De Schrijver)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Attached you will find a patch to the tulip driver in Linux 2.4. This patch
will interpret a bit more of 21142 extended format type 3 info blocks in a 
tulip SROM. This allows correct autonegotation of the builtin 21143 based
ethernet adapter on a digital PWS500a(u). Maybe a future version should do
a more thorough interpretation of the SROM. 

Peter.



--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tulip

diff -rc linux.orig/drivers/net/tulip/eeprom.c linux/drivers/net/tulip/eeprom.c
*** linux.orig/drivers/net/tulip/eeprom.c	Sat Dec 30 20:23:14 2000
--- linux/drivers/net/tulip/eeprom.c	Fri Jan  5 19:02:36 2001
***************
*** 207,214 ****
--- 207,219 ----
  					p += (p[0] & 0x3f) + 1;
  					continue;
  				} else if (p[1] & 1) {
+ 					int gpr_len, reset_len;
+ 
  					mtable->has_mii = 1;
  					leaf->media = 11;
+ 					gpr_len=p[3]*2;
+ 					reset_len=p[4+gpr_len]*2;
+ 					new_advertise |= get_u16(&p[7+gpr_len+reset_len]);
  				} else {
  					mtable->has_nonmii = 1;
  					leaf->media = p[2] & 0x0f;

--X1bOJ3K7DJ5YkBrT--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
