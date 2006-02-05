Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWBERvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWBERvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 12:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWBERvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 12:51:09 -0500
Received: from smtpout.mac.com ([17.250.248.97]:13772 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751256AbWBERvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 12:51:08 -0500
In-Reply-To: <43E62492.6080506@cfl.rr.com>
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <"787b0d920602 <Pine.LNX.4.61.0602050838110.6749"@yvahk01.tjqt.qr> <43E62492.6080506@cfl.rr.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E4D853FC-34C1-4332-BF92-D90E059D7543@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Krzysztof Halasa <khc@pm.waw.pl>,
       Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Sun, 5 Feb 2006 12:50:50 -0500
To: Phillip Susi <psusi@cfl.rr.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 05, 2006, at 11:15, Phillip Susi wrote:
> Jan Engelhardt wrote:
>> I would say we all forgot to RTFM. Because O_EXCL does nothing  
>> *unless* O_CREAT is specified, which probably *is not* specified  
>> in cdrecord or hal. There is no reason to have hal or cdrecord  
>> create a device node - which you can't do with open() anyway.
>
> I think you are misinterpreting the man page, because it isn't  
> worded very clearly.  It should not even mention O_CREAT because it  
> has nothing to do with O_EXCL; it is just repeating the semantics  
> of O_CREAT ( if the file already exists, the call fails ) which  
> would of course, apply if you do use O_CREAT in conjunction with  
> any other flag including O_EXCL.  It does not say that you must use  
> O_EXCL with O_CREAT.  The rest of the description talks about using  
> lockfiles as an alternative to ensure exclusive access to the file  
> on NFS where O_EXCL is broken.  The intent of O_EXCL is clearly to  
> provide the caller with exclusive access to the file.

You don't have this right either.  The way open() works:

If you specify O_CREAT (and not O_EXCL), it will create the file if  
it does not exist, and open the existing file otherwise.

If you specify O_EXCL (and not O_CREAT), it is implementation defined  
what will happen (in the Linux case, this opens a block device for  
exclusive access).

If you specify O_CREAT|O_EXCL, it will atomically create the file if  
it does not exist, otherwise it will return the error -EEXIST.

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



