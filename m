Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291331AbSBMDwK>; Tue, 12 Feb 2002 22:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291332AbSBMDwB>; Tue, 12 Feb 2002 22:52:01 -0500
Received: from [63.204.6.12] ([63.204.6.12]:28395 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S291331AbSBMDvr>;
	Tue, 12 Feb 2002 22:51:47 -0500
Subject: memcmp() doesn't
From: "Georg Nikodym" <georgn@somanetworks.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linux ARM Kernel List <linux-arm-kernel@lists.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 12 Feb 2002 22:51:26 -0500
Message-Id: <1013572286.1581.95.camel@keller>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

User's of X86 won't care but the generic memcmp() routine in
lib/string.c is incorrect...

The code reads:

/**
 * memcmp - Compare two areas of memory
 * @cs: One area of memory
 * @ct: Another area of memory
 * @count: The size of the area.
 */
int memcmp(const void * cs,const void * ct,size_t count)
{
	const unsigned char *su1, *su2;
	signed char res = 0;

	for( su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
		if ((res = *su1 - *su2) != 0)
			break;
	return res;
}

Trouble is that the variable res is not big enough to hold all possible
results of a subtraction of two unsigned char quantities.

Changing res to int fixes things (and in the case of ARM, makes the
function smaller).

I can supply patches in BK or regular form but I suspect it'd be easier
for somebody "in the club" to simply make this change themselves.

-g

