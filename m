Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUGHSKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUGHSKf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 14:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUGHSKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 14:10:35 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:18791 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261602AbUGHSKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 14:10:32 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: David Balazic <david.balazic@hermes.si>
Subject: Re: [PATCH 2.6] Mousedev - better button handling under load
Date: Thu, 8 Jul 2004 13:10:29 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, fedora-list@redhat.com
References: <600B91D5E4B8D211A58C00902724252C035F1F18@piramida.hermes.si>
In-Reply-To: <600B91D5E4B8D211A58C00902724252C035F1F18@piramida.hermes.si>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407081310.29997.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 July 2004 08:25 am, David Balazic wrote:
> 	Hi,
> 
> 	Currently mousedev combines all hardware motion data that arrivers
> since
> 	last time userspace read data into one cooked PS/2 packet. The
> problem is
> 	that under heavy or even moderate load, when userspace can't read
> data
> 	quickly enough, we start loosing valuable data which manifests in:
> 
> 	- ignoring buton presses as by the time userspace gets to read the
> data
> 	  button has already been released;
> 	- click starts in wrong place - by the time userspace got aroungd
> and read
> 	  the packet mouse moved half way across the screen.
> 
> 
> I am seeing the second simptom on Fedora Core 2 in X.
> ( I click on a windows title, move the mouse and what happens is than a 
> selection rectangle is drawn on the desktop, starting a few inches away from
> the real click position )
> Is this the cause ?
>

Yes, I think it is. If userspace is behind then mousedev will continue
accumulating displacements after noticing click and when userspace finally
gets around to read the packet it looks like click was at the current
displacement point.
 
> Regards,
> David
> 
> P.S.: Is there a bug about this in bugzilla.redhat.com ? ( or elsewhere ? )

Not that I know of...

-- 
Dmitry
