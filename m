Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272439AbRIFJU1>; Thu, 6 Sep 2001 05:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272441AbRIFJUS>; Thu, 6 Sep 2001 05:20:18 -0400
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:43260 "HELO
	duron.intern.kubla.de") by vger.kernel.org with SMTP
	id <S272439AbRIFJUE>; Thu, 6 Sep 2001 05:20:04 -0400
Date: Thu, 6 Sep 2001 11:20:19 +0200
From: Dominik Kubla <kubla@sciobyte.de>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: joe@mathewson.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
Message-ID: <20010906112019.G11993@duron.intern.kubla.de>
In-Reply-To: <200109051913.f85JD2K01304@ambassador.mathewson.int> <200109052212.RAA64901@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109052212.RAA64901@tomcat.admin.navo.hpc.mil>
User-Agent: Mutt/1.3.20i
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 05:12:48PM -0500, Jesse Pollard wrote:
> 
> Kerberos won't help either - The only parts of NFS that were kerberized
> was the initial mount. Everything else uses filehandles/UDP. Encryption
> doesn't help either - slows the entire network down too much.

I disagree! First of all you can always use NFS over TCP, so much for
"every thing else uses filehandles/UDP". (No that this improves security,
but it can improve reliability!)

True: krb5 only authenticates the mount, but krb5i also computes a
MD5-based message authentication code on every RPC request to the server
and every RPC reply to the client, thus providing integrity protection.
krb5p uses DES encryption to provide privacy.  Unfortunately only Solaris
with SEAM and SEAS (or AdminPack for Solaris 8) seems to implement this.
I would love to see a Linux implementation of this!

I would like to recommend "Managing NFS and NIS" (2nd ed) from O'Reilly,
especially chapter 12 "Network Security".  That chapter discusses the
mechanismns described above as well as performance and relation to IPsec
(for the impatient: using AH+ESP will give you HOST-based security, while
using krb5+krb5i+krb5p will give you USER-based security)

As for encryption slowing down the network: security does not come for free.
It is the task of the System Administrator to evalute his security requirements
against the required performance of the installation and take the appropriate
measures. Nobody ever said that was easy. It if was every MCSE could do it!

The author of "Managing NFS and NIS" (2nd ed) gave some figures on performance
degradation using krb5 (using two Ultra 5 w Solaris 8, using NFS over TCP):

	Auth	Throughput	Degradation	CPU util.
                 (MB/sec)	rel. to "sys"

	sys	5.4		-		69%
	krb5	5.26		2.6%		70%
	krb5i	4.44		17.7%		77%
	krb5p	1.45		73.1%		99%

(Test involved writing a 200MB file to the tmpfs of the server using the
mkfile utility. I am sure one could run better tests, but...)

Now i would be more concerned with the increas in CPU utilisation than
the throughput degradation. Why? If i truly need to protect sensitive
information with encryption, i can wait for the data. But making the
server unusable for the duration of the data transfer is in most cases
not acceptable.

Dominik Kubla
-- 
ScioByte GmbH, Zum Schiersteiner Grund 2, 55127 Mainz (Germany)
Phone: +49 6131 550 117  Fax: +49 6131 610 99 16

GnuPG: 717F16BB / A384 F5F1 F566 5716 5485  27EF 3B00 C007 717F 16BB
