Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423101AbWJYHwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423101AbWJYHwn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423103AbWJYHwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:52:43 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:10921 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423101AbWJYHwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:52:42 -0400
Date: Wed, 25 Oct 2006 09:52:38 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: arnd@arndb.de
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, paulus@samba.org
Subject: Re: [PATCH 11/16] sysfs: add support for adding/removing spu sysfs attributes
Message-ID: <20061025075238.GA7090@osiris.boeblingen.de.ibm.com>
References: <20061024163113.694643000@arndb.de> <20061024163816.460479000@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024163816.460479000@arndb.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +int cpu_add_sysdev_attr(struct sysdev_attribute *attr)
> +{
> +	int cpu;
> +
> +	mutex_lock(&cpu_mutex);
> +
> +	for_each_possible_cpu(cpu) {
> +		sysdev_create_file(get_cpu_sysdev(cpu), attr);
> +	}
> +
> +	mutex_unlock(&cpu_mutex);
> +	return 0;
> +}

You probably should check for errors on sysdev_create_file, clean up and
return an error number instead of always 0.
This is true for all the new functions here.
