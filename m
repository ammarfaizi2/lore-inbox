Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318244AbSG3Mco>; Tue, 30 Jul 2002 08:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318245AbSG3Mco>; Tue, 30 Jul 2002 08:32:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8853 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318244AbSG3Mcn>;
	Tue, 30 Jul 2002 08:32:43 -0400
Subject: RE: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFAF01BB69.D29E7D2F-ON87256C05.006F1BA4@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Tue, 30 Jul 2002 07:36:06 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 07/30/2002 06:36:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Tony Luck writes ..
>You don't specify any details of how the "singly linked list of
>free objects" would be implemented.  You cannot use any of the
>memory in the freed object (as the constructor for a slab is only
>called when memory is first allocated, not when an object is recycled)
>so using any part of the object might confuse a caller by giving them
>a corrupted object.
I am creating a link list of free objects per cpu. When objects are
deallocated by the caller they get added to its cpu free object link
list.  The freed objects do not migrate to other caches, they are put
back to the present cpu's link list. so they don't have to be
re-initialized.  I am planning on putting a (configurable) limit on
the number of free objects that can stay in a free list.

>Are you going to have some external structure to maintain the linked
>list?  Or secretly enlarge the object to provide space for the link,
>or some other way?
No I am using the object(beginning space) to store the links. When
allocated, I can initialize the space occupied by the link address.


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   Phone:838-8088; Tie-line:678-8088






