Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVAHLEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVAHLEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 06:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVAHLEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 06:04:01 -0500
Received: from pD9F86D6F.dip0.t-ipconnect.de ([217.248.109.111]:54145 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261855AbVAHLCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 06:02:41 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: ksymoops 2.4.10 segfaults
Date: Sat, 08 Jan 2005 12:01:57 +0100
Organization: privat
Message-ID: <croej5$5b8$1@pD9F86D6F.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20041217
X-Accept-Language: de, en-us, en
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


ksymoops segfaults in object.c while computing cmd_strlen, because
options->target is defined 'null':

/* Extract all symbols definitions from an object using nm */
static void read_nm_symbols(SYMBOL_SET *ss, const char *file, const
OPTIONS *options)
{
    FILE *f;
    char *cmd, *line = NULL, **string = NULL;
    int i, cmd_strlen, size = 0;
    static char const procname[] = "read_nm_symbols";
    static char const nm_options[] = "--target=";

    if (!regular_file(file, procname))
        return;

    printf ("Path to nm: %s\n",path_nm);
    printf ("nm_options: %s\n",nm_options);
    printf ("target: %s\n",(options->target));
    printf ("file: %s\n",file);
    cmd_strlen =
strlen(path_nm)+1+strlen(nm_options)+strlen(options->target)+1+strlen(file)+1;
    printf ("length: %d\n",cmd_strlen);
    cmd = malloc(cmd_strlen);


./ksymoops
ksymoops 2.4.10 on i686 2.4.29-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.29-pre3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Path to nm: /usr/local/bin/nm
nm_options: --target=
target: (null)
file: /lib-2.6/modules/2.4.29-pre3-swsusp/kernel/sound/pci/snd-via82xx.o
Segmentation fault (core dumped)


Kind regards,
Andreas Hartmann
