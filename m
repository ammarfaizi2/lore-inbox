Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286216AbRL0F7T>; Thu, 27 Dec 2001 00:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286218AbRL0F7K>; Thu, 27 Dec 2001 00:59:10 -0500
Received: from [202.54.64.2] ([202.54.64.2]:49414 "EHLO ganesh.ctd.hctech.com")
	by vger.kernel.org with ESMTP id <S286216AbRL0F7C>;
	Thu, 27 Dec 2001 00:59:02 -0500
Message-ID: <EF836A380096D511AD9000B0D021B52746370A@narmada.ctd.hcltech.com>
From: "Eshwar D - CTD, Chennai." <deshwar@ctd.hcltech.com>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMBFS reading & Time sync problem
Date: Thu, 27 Dec 2001 11:24:30 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hai,
	I am using kernel version 2.4.2. and samba version is 2.2.0. and
having two clients which are mounted using smbfs to same shared directory.
When i read a file xyz (file is in smbfs mounted directory) from one client
and i am didn't closed, from second client i written some data using write
system call and closed xyz file,  i am not seen the updated data from client
one. Then i closed file in client one and tried to read the data, but I am
not able to read the updated data. As I observed that when second client is
written the data and closes the Modified time is changed for the file xyz in
the server and when I closed the fist client the modified time is over
written by fist client. When I reading the file once again from in fist
client, client is checking the modified time in the server, in the veiw of
fist client modified time is not changed, fist client is reading data in
page cache insted of getting the data from the server. The above situation
is occuring due to the following things
	
	1. The file attributes are changing only at the time of closing the
file not while writing.

 To avoid this problem my suggestion is

	1. While every write the modified time to be notified to sever by
sending SMBsetattr.

	2. While reading client has to get the modified time and copy the
client access time and the recent modified time ( I mean modified time sent
by the server) request the server to set the attributes by sending
SMBsetattr.
	
Thanks 
D.Eshwar,
Member Techinical Staff,
HCL Techonologies Ltd.,
D-12 & 12-B, 3rd South Street,
SIDCO Industrial Estate,
Ambattur,
Chennai - 600 058.
Ph:- 044-6230711/12/13/14 Ext 2624

Disclaimer:
This document is intended for transmission to the named recipient only.  If
you are not that person, you should note that legal rights reside in this
document and you are not authorized to access, read, disclose, copy, use or
otherwise deal with it and any such actions are prohibited and may be
unlawful. The views expressed in this document are not necessarily those of
HCL Technologies Ltd. Notice is hereby given that no representation,
contract or other binding obligation shall be created by this e-mail, which
must be interpreted accordingly. Any representations, contractual rights or
obligations shall be separately communicated in writing and signed in the
original by a duly authorized officer of the relevant company.




-----Original Message-----
From: Urban Widmark [mailto:urban@teststation.com]
Sent: Wednesday, December 12, 2001 11:31 PM
To: Eshwar D - CTD, Chennai.
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem SMBFS


On Tue, 11 Dec 2001, Eshwar D - CTD, Chennai. wrote:

> 	When i read a file xyz (file is in smbfs mounted directory) from one
> client and i am didn't closed, from second client i written some data
using
> write system call and closed xyz file,  i am not see the data from client
> one. Then i closed file in client one and tried to read the data, same
thing
> is continuing. Can any one suggest me is this is the property of smbfs. I
am
> not a member in mailing list please send me u r request to my mail id

Kernel version? This sounds a lot like a problem fixed sometime around
2.2.18 where smbfs didn't consider certain files as changed.

Are both clients smbfs?

/Urban
