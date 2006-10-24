Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWJXSmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWJXSmc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWJXSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:42:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:9873 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161171AbWJXSmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:42:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=blVpHBkCLtW/Zx5BnVMU5qymBSy8gmSKiFU9fVoHYm/kyINj+DWLwIPSMdUu5wfPLOd10x7lQqz+ZUfUB/5uupdM55AmUH46br42JllPWtY4SqUhw7Kl4QIQckH5sD+gJDseJBrttZYtQu08YjqJritooF9WLlfCfFNI0XZ2pWQ=
Message-ID: <84144f020610241142y2c86485dj898f555174803577@mail.gmail.com>
Date: Tue, 24 Oct 2006 21:42:06 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
Cc: "Paul Mackerras" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       "Arnd Bergmann" <arnd.bergmann@de.ibm.com>
In-Reply-To: <20061024160406.923275000@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061024160140.452484000@arndb.de>
	 <20061024160406.923275000@arndb.de>
X-Google-Sender-Auth: 9e7a6b17ab12825a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 10/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
>         spu_acquire(ctx);
> -       for (count = 0; count <= len; count += 4, udata++) {
> +       for (count = 0; (count + 4) <= len; count += 4, udata++) {

Wouldn't this be more obvious as

  for (count = 0, count < (len / 4); count++, udata++) {

And then do count * 4 if you need the actual index somewhere. Hmm?
