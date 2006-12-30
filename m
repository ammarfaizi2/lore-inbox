Return-Path: <linux-kernel-owner+w=401wt.eu-S1030265AbWL3Dcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWL3Dcc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 22:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWL3Dcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 22:32:32 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:3956 "EHLO
	asav14.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030265AbWL3Dcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 22:32:31 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AusRAH9slUVKhRO4UGdsb2JhbACHN4ZJAQEq
From: Dmitry Torokhov <dtor@insightbb.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: Display class
Date: Fri, 29 Dec 2006 22:32:43 -0500
User-Agent: KMail/1.9.3
Cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org> <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org> <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
In-Reply-To: <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612292232.44122.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 05 December 2006 13:03, James Simmons wrote:
> +int probe_edid(struct display_device *dev, void *data)
> +{
> +       struct fb_monspecs spec;
> +       ssize_t size = 45;

const ssize_t size = 45? 

> +
> +       dev->name = kzalloc(size, GFP_KERNEL);

Why do you need kzalloc here?

> +       fb_edid_to_monspecs((unsigned char *) data, &spec);
> +       strcpy(dev->name, spec.manufacturer);

You seem to be overwriting dev->name in the very next line?

> +       return snprintf(dev->name, size, "%s %s %s\n", spec.manufacturer, spec.monitor, spec.ascii);
> 

Is result of snprintf interesting to the callers?

-- 
Dmitry
