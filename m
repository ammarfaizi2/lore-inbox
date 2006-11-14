Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966317AbWKNURE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966317AbWKNURE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966313AbWKNURD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:17:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:49965 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S966314AbWKNURA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:17:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ClpFm8DNnKxY3VgmunA9T4zXZrdbYDGX7X4uR40zOi0AxYHnAarD6LdDj4bj/zwge+EGRlsh4CJ5v7qU3/irUyIMBxwgfojd2QiUHgMr7hlKvVzNITHJ0nfTVUlpYozIJJDSitrcshVVJBoxHDOSUxQrZQoShAKUGD9ucZ6WAKI=
Message-ID: <d120d5000611141216o1a38c319kdd1c59694620eb9a@mail.gmail.com>
Date: Tue, 14 Nov 2006 15:16:58 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Burman Yan" <yan_952@hotmail.com>
Subject: Re: [PATCH 2.6.19-rc5] hwmon: HP Mobile data protection system 3D driver version 0.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY20-F15478226E1B68570B38803D8EB0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY20-F15478226E1B68570B38803D8EB0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/06, Burman Yan <yan_952@hotmail.com> wrote:
> Hi.
>
> I took into account previous remarks, so here is the new version of the
> driver
> for the accelerometer present in HP nc6400 laptops. See documentation in the
> patch
> for complete feature list. At this point I don't think there is anything
> more that can
> be added to this driver and also it works stable for me no matter how I
> tried to abuse it.
>

Hi,

I don't think that you need a spinlock to protect mdps.count. Just
make it atomic_t and use atomic_xchg(&mdps.count, 0) in
mdaps_misc_read to get and reset it.

Also why are you settng EV_KEY bit on the input device? You are not
reporintg any key events...

-- 
Dmitry
