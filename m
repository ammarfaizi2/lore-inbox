Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWGYNBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWGYNBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 09:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWGYNBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 09:01:14 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:10633
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751396AbWGYNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 09:01:13 -0400
Message-ID: <44C61616.7060203@ed-soft.at>
Date: Tue, 25 Jul 2006 15:01:10 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 07/45] v4l/dvb: Fix CI on old KNC1 DVBC cards
References: <20060717160652.408007000@blue.kroah.org> <20060717162617.GH4829@kroah.com>
In-Reply-To: <20060717162617.GH4829@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This fix does not compile on 2.6.17.7.
philips_cu1216_tuner_set_params is nowhere defined in the kernel tree.

cu

Edgar (gimli) Hucek
 
Greg KH schrieb:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> From: Andrew de Quincey <adq_dvb@lidskialf.net>
> 
> These cards do not need the tda10021 configuration change when data is
> streamed through a CAM module. This disables it for these ones.
> 
> Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
> Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> 
>  drivers/media/dvb/ttpci/budget-av.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- linux-2.6.17.3.orig/drivers/media/dvb/ttpci/budget-av.c
> +++ linux-2.6.17.3/drivers/media/dvb/ttpci/budget-av.c
> @@ -1060,6 +1060,15 @@ static void frontend_init(struct budget_
>  		break;
>  
>  	case SUBID_DVBC_KNC1:
> +		budget_av->reinitialise_demod = 1;
> +		fe = tda10021_attach(&philips_cu1216_config,
> +				     &budget_av->budget.i2c_adap,
> +				     read_pwm(budget_av));
> +		if (fe) {
> +			fe->ops.tuner_ops.set_params = philips_cu1216_tuner_set_params;
> +		}
> +		break;
> +
>  	case SUBID_DVBC_KNC1_PLUS:
>  		fe = tda10021_attach(&philips_cu1216_config,
>  				     &budget_av->budget.i2c_adap,
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

