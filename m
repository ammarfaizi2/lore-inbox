Return-Path: <linux-kernel-owner+w=401wt.eu-S1030298AbXADXyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbXADXyh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbXADXyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:54:36 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3015 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030295AbXADXyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:54:35 -0500
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: Stelian Pop <stelian@popies.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <lenb@kernel.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <20070104154434.7e1a7c83.akpm@osdl.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <1167953784.4901.5.camel@localhost.localdomain>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 05 Jan 2007 00:54:32 +0100
Message-Id: <1167954872.4901.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 04 janvier 2007 à 15:44 -0800, Andrew Morton a écrit :
> On Fri, 05 Jan 2007 00:36:23 +0100
> Stelian Pop <stelian@popies.net> wrote:
> 
> > Added acpi_bus_generate event for forwarding Fn-keys pressed to acpi subsystem,
> > and made correspondent necessary changes for this to work.
> 
> neato.
> 
> err, how does one use this?

:)

Well, it seems that on some Vaios (including Nilton's pcg-frv26 but not
only this one), the Fn key events aren't seen by sonypi or sony_acpi
GHKE method, but do generate an ACPI notify event.

For those laptops, the patch forwards the ACPI event to the ACPI system
and can be later interpreted in userspace using
acpid's /etc/acpi/default.sh (example directly from Nilton):

> case "$group" in
>     button)
>         case "$action" in
>             power) /usr/sbin/hibernate
>                 ;;
>
>             lid) cat /proc/acpi/button/lid/LID/state
>                 ;;
> 
>             *)  logger "ACPI action $action is not defined ($@)"
>                 ;;
>         esac
>         ;;
> 
>     SNC) echo "$@" > /dev/tcp/localhost/50007
>         ;;
> 
>     *) logger "ACPI group $group / action $action is not defined"
>         ;;
> esac
> 
> In which I just forward the SNC event to another userspace application
> listening on a TCP port.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

