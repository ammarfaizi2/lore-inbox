Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTBILyR>; Sun, 9 Feb 2003 06:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTBILyR>; Sun, 9 Feb 2003 06:54:17 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:49168 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267219AbTBILyP>; Sun, 9 Feb 2003 06:54:15 -0500
Date: Sun, 9 Feb 2003 12:03:58 +0000
From: John Levon <levon@movementarian.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030209120358.GB10576@compsoc.man.ac.uk>
References: <20030209113201.GA1296@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209113201.GA1296@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18hqBj-000DJ3-00*nfaLp3W8SL6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 12:32:01PM +0100, Pavel Machek wrote:

>  static void nmi_shutdown(void)
>  {
> -	unset_nmi_pm_callback(oprofile_pmdev);
> +	nmi_enabled = 0;
>  	unset_nmi_callback();
>  	smp_call_function(nmi_cpu_shutdown, NULL, 0, 1);
>  	nmi_cpu_shutdown(0);
> +	if (nmi_watchdog == NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE) {
> +		nmi_watchdog = NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE;
> +		setup_apic_nmi_watchdog();
> +	}

It looks  to me like you'll end up enabilng the watchdog even if user
didn't enable the watchdog at boot up. Also, setup_apic_nmi_watchdog()
and the disable function need to exported to modules.

john
