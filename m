Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRBVUaq>; Thu, 22 Feb 2001 15:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129727AbRBVUag>; Thu, 22 Feb 2001 15:30:36 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:31242 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129589AbRBVUaW>; Thu, 22 Feb 2001 15:30:22 -0500
Date: 22 Feb 2001 20:38:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: Linux-kernel@vger.kernel.org
Message-ID: <7wNdS6-Xw-B@khms.westfalen.de>
In-Reply-To: <01022020011905.18944@gimli>
Subject: Re: [rfc] Near-constant time directory index for Ext2
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <01022020011905.18944@gimli>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@innominate.de (Daniel Phillips)  wrote on 20.02.01 in <01022020011905.18944@gimli>:

> But the current hash function is just a place holder, waiting for
> an better version based on some solid theory.  I currently favor the
> idea of using crc32 as the default hash function, but I welcome
> suggestions.

I once liked those things, too - but I've learned better since.

Quoting _Handbook_of_Algorithms_and_Data_Structures_ (Gonnet/Baeza-Yates,  
ISBM 0-201-41607-7, Addison-Wesley):

--- snip ---

3.3.1 Practical hashing functions

[...]

A universal class of hashing functions is a class with the property that  
given any input, the average performance of all the functions is good.  
[...] For example, h(k) = (a * k + b) mod m with integers a != 0 and b is  
a universal class of hash functions.
[...]
Keys which are strings or sequences of words (including those which are of  
variable length) are best treated by considering them as a number base b.  
Let the string s be composed of k characters s1s2...sk. Then

        h(s) = ( sum(i=0..k-1) B^i*s(k-i) ) mod m

To obtain a more efficient version of this function we can compute

        h(s) = ( ( sum(i=0..k-1) B^i*s(k-i) ) mod 2^w ) mod m

where w is the number of bits in a computer word, and the mod 2^w  
operation is done by the hardware. For this function the value B = 131 is  
recommended, as B^i has a maximum cycle mod 2^k for 8<=k<=64.

Hashing function for strings

        int hashfunction(s)
        char *s;

        { int i;
          for(i=0; *s; s++) i = 131*i + *s;
          return(i % m);
        }

--- snip ---

I've actually used that function for a hash containing something like a  
million phone numbers as keys, and there were *very* few collisions.  
Similarly for another hash containgng megabytes of RFC 822 message-ids.

MfG Kai
