Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136811AbRECNwq>; Thu, 3 May 2001 09:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136808AbRECNw1>; Thu, 3 May 2001 09:52:27 -0400
Received: from stat8.steeleye.com ([63.113.59.41]:42253 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S136807AbRECNwZ>; Thu, 3 May 2001 09:52:25 -0400
Message-Id: <200105031352.JAA01246@localhost.localdomain>
X-Mailer: exmh version 2.1.1 10/15/1999
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Doug Ledford <dledford@redhat.com>,
        Mike Anderson <mike.anderson@us.ibm.com>,
        Eric.Ayers@intec-telecom-systems.com,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi 
In-Reply-To: Message from James Bottomley <James.Bottomley@SteelEye.com> 
   of "Thu, 03 May 2001 08:53:42 EDT." <200105031253.IAA00988@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 09:52:03 -0400
From: James Bottomley <James.Bottomley@SteelEye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is another nasty in multi-port arrays that I should perhaps point out:  
a bus reset isn't supposed to drop the reservation if it was taken on another 
port.  A device or LUN reset will drop reservations on all ports.  This 
behaviour, although clearly mandated by the SCSI-3-SPC, is rather patchily 
implemented in arrays and I have seen some multi-port arrays that will, 
illegally, drop reservations on all ports on receipt of a bus reset.

Unfortunately, most Linux SCSI drivers won't issue device resets on command, 
they'll only issue bus resets, so it is possible to get into a situation where 
you cannot break a reservation belonging to a dead machine, if you set up a 
point-to-point cluster rather than a true shared-scsi one.

James


