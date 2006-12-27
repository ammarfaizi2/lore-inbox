Return-Path: <linux-kernel-owner+w=401wt.eu-S932910AbWL0FNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932910AbWL0FNm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 00:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932912AbWL0FNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 00:13:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:64424 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910AbWL0FNk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 00:13:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TFcv7d4g+NObsnwLy2L3sSSJLEGEWNZ/Z45vuxxUpAEnCiltbY7w7fDW3H4nZY7BQ/GUjWkkEXIas9Vgnfdncj5WNDvm/w8OIU0kjcBBzBTPpYQ5y3T5yywoQ+L3SH+EHvhv3F6k6c9iPUypO1OR+SJ5TKBA1uyl9eb/M3EyZKE=
Message-ID: <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com>
Date: Tue, 26 Dec 2006 21:13:39 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Rob Landley" <rob@landley.net>
Subject: Re: Feature request: exec self for NOMMU.
Cc: linux-kernel@vger.kernel.org,
       "David McCullough" <david_mccullough@au.securecomputing.com>
In-Reply-To: <200612261823.07927.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612261823.07927.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/06, Rob Landley <rob@landley.net> wrote:
> I'm trying to make some nommu-friendly busybox-like tools, which means using
> vfork() instead of fork().  This means that after I fork I have to exec in
> the child to unblock the parent, and if I want to exec my current executable
> I have to find out where it lives so I can feed the path to exec().  This is
> nontrivial.
>
> Worse, it's not always possible.  If chroot() has happened since the program
> started, there may not _be_ a path to my current executable available from
> this process's current or root directories.

How about openning an fd to yourself at the beginning of execution, then calling
fexecve later?
