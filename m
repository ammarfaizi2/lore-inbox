Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVEZTf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVEZTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 15:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVEZTf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 15:35:57 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:21331 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261714AbVEZTfg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 15:35:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fge6TIsKBeHn9fPl+BeR+mK3Jdn7W7vDH+Wx2G28Tm0qdEATD7ksKffn7J9Km1FsCfcOBM6jiwDEOTO5RqL8f/zindsZ+VBpwJj/X7ZC6CO+6+Nm+URNoIfw58VIZjUXC+AL/xRaGqvPqt8YHp4NDLqAUbWkmlKMYJPZxdZ5Z2Y=
Message-ID: <8783be6605052612354c09ab8b@mail.gmail.com>
Date: Thu, 26 May 2005 15:35:33 -0400
From: Ross Biro <ross.biro@gmail.com>
Reply-To: Ross Biro <ross.biro@gmail.com>
To: Jim Gifford <maillist@jg555.com>
Subject: Re: Random IDE Lock ups with via IDE
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42961567.1010906@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4293B859.3070609@jg555.com> <4294BAE8.5050803@jg555.com>
	 <8783be6605052513343fce843b@mail.gmail.com>
	 <4294E409.9020907@jg555.com>
	 <8783be6605052516577daeebdf@mail.gmail.com>
	 <42961567.1010906@jg555.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you are using the legacy IDE layer you want to tweak WAIT_CMD.  For
testing, you can make it really large and see if that impacts your
problem.  A drive vendor once told me that it could take more than a
minute for an IDE drive to complete a command.  I no longer purchase
drives from that vendor.

I'm not sure what libata uses, but my guess is it defaults it from the
SCSI layer.

If tweaking these time outs make your problem go away, odds are what
happened was that your drive remapped a few more bad sectors and now
takes a little too long to complete commands.  The linux ide error
recovery code does a WIN_IDLE_IMMEDIATE when there is a problem.  This
is allowed by the ATA-2 spec, but confuses most modern drives.  So
once you start getting errors, often the drive gets so confused, you
never stop.

    Ross

On 5/26/05, Jim Gifford <maillist@jg555.com> wrote:
> What do you recommend trying?
>
