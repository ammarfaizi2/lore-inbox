Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132942AbRDRBNl>; Tue, 17 Apr 2001 21:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132948AbRDRBNa>; Tue, 17 Apr 2001 21:13:30 -0400
Received: from p3EE3C9F7.dip.t-dialin.net ([62.227.201.247]:44807 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S132941AbRDRBNU>; Tue, 17 Apr 2001 21:13:20 -0400
Date: Wed, 18 Apr 2001 03:13:12 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: ip_masq_ftp in 2.2.19
Message-ID: <20010418031312.A31160@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ip_masq_ftp does case sensitive comparisons of FTP commands when
snooping the control connection, and may thus miss legitimate PORT/PASV
negotiation. The culprit is the use of safe_mem_eq2 to match on the
commands, it catches them in either all-caps or all-lower-case (PASV,
pasv), but not in mixed case (PaSv) or with trailing whitespace ("PaSv
"), while RFC-959 (FTP) demands case insensitive handling of FTP
commands.

I don't currently have time to fix this myself and submit a patch,
sorry.

-- 
Matthias Andree
