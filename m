Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSIDT30>; Wed, 4 Sep 2002 15:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSIDT30>; Wed, 4 Sep 2002 15:29:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:30852 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315267AbSIDT3Z>; Wed, 4 Sep 2002 15:29:25 -0400
Date: Wed, 4 Sep 2002 10:13:22 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jeremy Higdon <jeremy@classic.engr.sgi.com>,
       Doug Ledford <dledford@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset?
Message-ID: <20020904171322.GA1645@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Jeremy Higdon <jeremy@classic.engr.sgi.com>,
	Doug Ledford <dledford@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <10209040040.ZM49716@classic.engr.sgi.com> <200209041624.g84GOJC02683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209041624.g84GOJC02683@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley [James.Bottomley@steeleye.com] wrote:
> jeremy@classic.engr.sgi.com said:
> > For example, in Fibrechannel using class 3 (the usual)
> 
> > 	send command (command frame corrupted; device does not receive)
> > 	send barrier (completes normally)
> > 	... (lots of time goes by, many more commands are processed)
> > 	timeout original command whose command frame was corrupted 
> 
> This doesn't look right to me from the SCSI angle  I don't see how you can get 
> a successful disconnect on a command the device doesn't receive (I take it 
> this is some type of Fibre magic?).  Of course, if the device (or its proxy) 
> does receive the command then the ordered queue tag implementation requires 
> that the corrupted frame command be processed prior to the barrier,  this 
> isn't optional if you obey the spec.  Thus, assuming the processor does no 
> integrity checking of the command until it does processing (this should be a 
> big if), then we still must get notification of the failed command before the 
> barrier tag is begun.  Obviously, from that notification we do then race to 
> eliminate the overtaking tags.

In FC class 3 if you are logged into a port then notice of this loss
doesn't happen until a upper level timeout occurs (ULTP?). The loss can
happen prior to the command reaching the device (i.e. the switch can
drop the frame). If a corrupted frame makes it to the device it will be
discarded as there is not much it can do with a frame containing unreliable
data. In FC class 2 frames are ack'd so the recovery can be much more
responsive.


-Mike
-- 
Michael Anderson
andmike@us.ibm.com

