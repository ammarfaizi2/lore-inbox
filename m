Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263658AbVBCSkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbVBCSkl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbVBCSkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:40:20 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:55657 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263658AbVBCSjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:39:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TIvlHRm6HOJBdpPDgTG8LSqFCWXmVx4FuMhXp+Zfd2zQ3RidFPypXqq0VZ5OZ83QLOkrYTiUNcmLvzPO2pbIYiEJ4scc2s+lG1khvxiBHcrsL95ZWDV/HtooIM6XQb4K2+dLZITq4bUuk1ON51uEjBUBTptd81C3hhm+S9NaJvQ=
Message-ID: <58cb370e050203103952e1cd22@mail.gmail.com>
Date: Thu, 3 Feb 2005 19:39:19 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 21/29] ide: Merge do_rw_taskfile() and flagged_taskfile().
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202030603.GF1187@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202030603.GF1187@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 12:06:03 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 21_ide_do_taskfile.patch
> >
> >       Merged do_rw_taskfile() and flagged_taskfile() into
> >       do_taskfile().  During the merge, the following changes took
> >       place.
> >       1. flagged taskfile now honors HOB feature register.
> >          (do_rw_taskfile() did write to HOB feature.)
> >       2. No do_rw_taskfile() HIHI check on select register.  Except
> >          for the DEV bit, all bits are honored.
> >       3. Uses taskfile->data_phase to determine if dma trasfer is
> >          requested.  (do_rw_taskfile() directly switched on
> >          taskfile->command for all dma commands)
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

do_rw_taskfile() is going to be used by fs requests once
__ide_do_rw_disk() is converted to taskfile transport.

I don't think that do_rw_taskfile() and flagged_taskfile() merge
is a good thing as it adds unnecessary overhead for hot path
(fs requests).
