Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWJWSBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWJWSBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWJWSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:01:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1778 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964975AbWJWSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:01:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hx7m1g+Xu9jOZ+jPsuVjamu2w9HDnKm7ZOCqO6cBcNknpoomngr76euxq0vVc3FlV0Y+QkhQZgW0OyCsunJ3g7qvdGfQLBaZtdlWUptbhULDWLN5v90KXHr5aCLl8lDlkWteNTGk6IhquaSh/fQ9DrrXP6Q+I17p4/rFqrOXxQg=
Message-ID: <a63d67fe0610231101v2f407e7dv46adaf8dbb0fb4e@mail.gmail.com>
Date: Mon, 23 Oct 2006 11:01:36 -0700
From: "Dan Carpenter" <error27@gmail.com>
To: "Neil Horman" <nhorman@tuxdriver.com>
Subject: Re: [KJ] [PATCH] Correct misc_register return code handling in several drivers
Cc: kernel-janitors@lists.osdl.org, akpm@osdl.org, maxk@qualcomm.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       kjhall@us.ibm.com
In-Reply-To: <20061023171910.GA23714@hmsreliant.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Neil Horman <nhorman@tuxdriver.com> wrote:
> +out3:
> +       for_each_online_node(node) {
> +               if(timers[node] != NULL)
> +                       kfree(timers[node]);
> +       }

Tharindu is going to be unhappy out if he sees that.  There is a
possibility that timers[node] is uninitialized.  if node[0] is null
then node[1] is uninitialized and it's going to cause a crash.

regards,
dan carpenter
