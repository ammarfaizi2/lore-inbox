Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161328AbWF0Vql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161328AbWF0Vql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbWF0Vql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:46:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:45640 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161328AbWF0Vqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:46:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C+nTDOcjNOPDDgxpMD9UuigDZANTwhhRyBVQ482duLgG1YdklfzDInz+CKigda9VcMecqPub9sSRzAbnTuCamvydoaFcIuDPgk9Hlya3QBjb95fAWUq1BrRXiU4dAMd9IObs+EKd2to7Zh+XnWY3yRbQApSeSgLQ8d0hVdgNzpw=
Message-ID: <29495f1d0606271446y79ffef0aiffe445ee9e3909cd@mail.gmail.com>
Date: Tue, 27 Jun 2006 14:46:39 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Marko Macek" <Marko.Macek@gmx.net>
Subject: Re: USB input ati_remote autorepeat problem
Cc: vojtech@suse.cz, thoffman@arnor.net, vanackere@lif.univ-mrs.fr,
       linux-kernel@vger.kernel.org
In-Reply-To: <44A18C38.7040504@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44A18C38.7040504@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/06, Marko Macek <Marko.Macek@gmx.net> wrote:
> Hello!
>
> I have problems with autorepeat in ati_remote (drivers/usb/input) driver
> in "recent" kernels: all keys start repeating immediately without some
> delay.
>
> This makes some things, like changing the channel prev/next or toggling
> fullscreen, etc... impossible/hard.
>
> The problem seems to be related to FILTER_TIME and HZ=250 (which I
> forgot to change).
>
> FILTER_TIME is defined to HZ / 20, and since 250 is not divisible by 20,
> the time will be too short to ignore enough events.
>
> Defining FILTER_TIME to HZ / 20 + 1 seems to fix things, but I'm not
> sure if there are any bad side effects.

Can you try just defining it to msecs_to_jiffies(50)? That should
handle the various HZ cases just fine.

Thanks,
Nish
