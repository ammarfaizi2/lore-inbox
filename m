Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTERQBP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTERQBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 12:01:15 -0400
Received: from cave-fxp0.tnc.ru ([81.211.38.202]:56201 "HELO hsys.msk.ru")
	by vger.kernel.org with SMTP id S262115AbTERQBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 12:01:14 -0400
To: Manuel Estrada Sainz <ranty@debian.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface, third round and a halve
From: Alexey Mahotkin <alexm@hsys.msk.ru>
Date: Sun, 18 May 2003 20:14:06 +0400
Message-ID: <877k8oqlkh.fsf@192.168.10.23>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two comments on firmware_class_hotplug(), maybe both are irrelevant.

+int firmware_class_hotplug(struct class_device *class_dev, char **envp,
+			   int num_envp, char *buffer, int buffer_size)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	int i=0;
+	char *scratch=buffer;
+
+	if (buffer_size < (FIRMWARE_NAME_MAX+10))
+		return -ENOMEM;
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
+	return 0;
+}
+

First, I do not understand how the environment is handled here.  You're
just setting first element of provided environment to "FIRMWARE=%s",
possibly overwriting the existing value.  Then why are you incrementing
`i'?  Why are you using `i' at all?  Why are you incrementing `scratch'?

Ah, it seems like you should be using num_envp somehow, and you're not.

Also, environment pointer list must be terminated with a NULL pointer. Is
it not done or is that handled somewhere else?  The machine I have 2.5.69
sources is not reachable now so I cannot check it.  Sorry if I am wrong.

--alexm
