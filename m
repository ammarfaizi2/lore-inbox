Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVKQGOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVKQGOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 01:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbVKQGOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 01:14:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27535 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932087AbVKQGOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 01:14:34 -0500
Date: Wed, 16 Nov 2005 22:14:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jordan Crouse" <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH:  Fix poor pointer math in devinet_sysctl_register
Message-Id: <20051116221412.7ecea148.akpm@osdl.org>
In-Reply-To: <20051116232345.GA872@cosmic.amd.com>
References: <20051116232345.GA872@cosmic.amd.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jordan Crouse" <jordan.crouse@amd.com> wrote:
>
> This patch fixes pointer math that under certain circumstances, results
>  in really bad pointers. This was encountered on a system compiled for i486, so
>  other compilers may differ, but I don't think it hurts anyone.
> 
>  Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
>  ---
> 
>   net/ipv4/devinet.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
> 
>  diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
>  index 4ec4b2c..7585fce 100644
>  --- a/net/ipv4/devinet.c
>  +++ b/net/ipv4/devinet.c
>  @@ -1454,7 +1454,7 @@ static void devinet_sysctl_register(stru
>   		return;
>   	memcpy(t, &devinet_sysctl, sizeof(*t));
>   	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
>  -		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
>  +		t->devinet_vars[i].data += (int)((char *)p - (char *)&ipv4_devconf);

Confused.  These appear to be equivalent (on 32-bit CPUs, anyway).

