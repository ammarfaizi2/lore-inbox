Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274842AbRJJFgM>; Wed, 10 Oct 2001 01:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274851AbRJJFgE>; Wed, 10 Oct 2001 01:36:04 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:3815 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S274842AbRJJFft>; Wed, 10 Oct 2001 01:35:49 -0400
Message-ID: <3BC3DE5D.8000500@wipro.com>
Date: Wed, 10 Oct 2001 11:06:29 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial patch for SIOCGIFCOUNT
In-Reply-To: <3BC2FA63.6070006@wipro.com> <20011009.153746.59466398.davem@redhat.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>   From: "BALBIR SINGH" <balbir.singh@wipro.com>
>   Date: Tue, 09 Oct 2001 18:53:47 +0530
>
>   	To make the API orthogonal, I have included a patch for SIOCGIFCOUNT,
>   which currently returns -EINVAL. The only reason I am providing this patch
>   is to make the API complete and make it easier to port applications from
>   other UNIX like OS'es.
>
>There is no need for this change, and _EVEN_ if we put this
>change in today every APP out there would _STILL_ need to deal with
>all existing kernels which do not have SIOCGIFCOUNT implemented.
>
>Furthermore, SIOCGIFCOUNT also gives no new functionality that does
>not exist already.  SIOCGIFCONF with a zero size with give the
>behavior necessary to get the same answer as a SIOCGIFCOUNT would
>provide.  As far as I am aware, every system providing BSD sockets
>provides this SIOCGIFCONF "feature".
>
>Therefore, it is already quite easy to make applications portable
>between Linux and other BSD socket based systems.  Simply use the
>SIOCGIFCONF method throughout.
>
I had mentioned even earlier, the same functionality can be obtained otherwise.
I was talking about porting from SUN, HP-UX, AIX, etc. I have had people coming
to me and telling me that SIOCGIFNUM (equivalent to SIOCGIFCOUNT) does not exist
and I have had to ask them to use SIOCGIFCONF, if ifc.ifc_len and ifc.ifc_buf set
to '0', to obtain the total size. Again, it is not a must it should be around.
But since the ioctl is there, it might be good to have it work the way some one
reading a man page would expect it to work, or if somebody wanted to port some
application from Sun, HP-UX or AIX would just do

#define SIOCGIFNUM SIOCGIFCOUNT

and get his application to compile without changing the code

Regards,
Balbir

>
>Franks a lot,
>David S. Miller
>davem@redhat.com
>
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
