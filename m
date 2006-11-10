Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945905AbWKJBwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWKJBwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945908AbWKJBwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:52:36 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:33968 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945905AbWKJBwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:52:35 -0500
Message-ID: <4553DB5C.8030405@us.ibm.com>
Date: Thu, 09 Nov 2006 17:52:28 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Ulrich Drepper <drepper@redhat.com>, Zach Brown <zach.brown@oracle.com>,
       Dave Jones <davej@redhat.com>,
       Jean Pierre Dion <jean-pierre.dion@bull.net>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: [PATCH -mm 3/3][AIO] - AIO completion signal notification
References: <1163087717.3879.34.camel@frecb000686> <1163087946.3879.43.camel@frecb000686>
In-Reply-To: <1163087946.3879.43.camel@frecb000686>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué wrote:
>                       AIO completion signal notification
>
>  
> +
> +	/* Release task ref */
> +	if (req->ki_notify.notify == (SIGEV_SIGNAL|SIGEV_THREAD_ID))
> +		put_task_struct(req->ki_notify.target);
> +
Huh ?? I thought user can set SIGEV_SIGNAL or SIGEV_THREAD_ID.
Not both. Isn't it ? Shouldn't this be ?

    if ((req->ki_notify.notify == SIGEV_SIGNAL) || 
(req->ki_notify.notify == SIGEV_THREAD_ID))
       ...

Samething in get_task_struct() also..

Thanks,
Badari

