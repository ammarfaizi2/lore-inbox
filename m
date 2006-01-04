Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWACXs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWACXs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWACXqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:46:03 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:39317 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964930AbWACXpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:45:52 -0500
Message-Id: <200601040037.k040bXGT012534@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/12] UML - Formatting changes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Jan 2006 19:37:33 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a bunch of non-functional changes -
    return(foo); becomes return foo;
    some statements are broken across lines for readability
    some trailing whitespace is cleaned up
    open_one_chan took four arguments, three of which could be
deduced from the first.  Accordingly, they were eliminated.
    some examples of "} else {" had a newline added
    some whitespace cleanup in the indentation
    lines_init got some control flow cleanup
    some long lines were broken
    removed another emacs-specific C formatting comment

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/chan_kern.c	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/chan_kern.c	2006-01-03 17:28:00.000000000 -0500
@@ -58,7 +58,7 @@ static void *not_configged_init(char *st
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
-	return(NULL);
+	return NULL;
 }
 
 static int not_configged_open(int input, int output, int primary, void *data,
@@ -66,7 +66,7 @@ static int not_configged_open(int input,
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
-	return(-ENODEV);
+	return -ENODEV;
 }
 
 static void not_configged_close(int fd, void *data)
@@ -79,21 +79,21 @@ static int not_configged_read(int fd, ch
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
-	return(-EIO);
+	return -EIO;
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
-	return(-EIO);
+	return -EIO;
 }
 
 static int not_configged_console_write(int fd, const char *buf, int len)
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
-	return(-EIO);
+	return -EIO;
 }
 
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
@@ -101,7 +101,7 @@ static int not_configged_window_size(int
 {
 	my_puts("Using a channel type which is configured out of "
 	       "UML\n");
-	return(-ENODEV);
+	return -ENODEV;
 }
 
 static void not_configged_free(void *data)
@@ -135,17 +135,17 @@ int generic_read(int fd, char *c_out, vo
 	n = os_read_file(fd, c_out, sizeof(*c_out));
 
 	if(n == -EAGAIN)
-		return(0);
+		return 0;
 	else if(n == 0)
-		return(-EIO);
-	return(n);
+		return -EIO;
+	return n;
 }
 
 /* XXX Trivial wrapper around os_write_file */
 
 int generic_write(int fd, const char *buf, int n, void *unused)
 {
-	return(os_write_file(fd, buf, n));
+	return os_write_file(fd, buf, n);
 }
 
 int generic_window_size(int fd, void *unused, unsigned short *rows_out,
@@ -156,14 +156,14 @@ int generic_window_size(int fd, void *un
 
 	ret = os_window_size(fd, &rows, &cols);
 	if(ret < 0)
-		return(ret);
+		return ret;
 
 	ret = ((*rows_out != rows) || (*cols_out != cols));
 
 	*rows_out = rows;
 	*cols_out = cols;
 
-	return(ret);
+	return ret;
 }
 
 void generic_free(void *data)
@@ -186,25 +186,29 @@ static void tty_receive_char(struct tty_
 		}
 	}
 
-	if((tty->flip.flag_buf_ptr == NULL) || 
+	if((tty->flip.flag_buf_ptr == NULL) ||
 	   (tty->flip.char_buf_ptr == NULL))
 		return;
 	tty_insert_flip_char(tty, ch, TTY_NORMAL);
 }
 
-static int open_one_chan(struct chan *chan, int input, int output, int primary)
+static int open_one_chan(struct chan *chan)
 {
 	int fd;
 
-	if(chan->opened) return(0);
-	if(chan->ops->open == NULL) fd = 0;
-	else fd = (*chan->ops->open)(input, output, primary, chan->data,
-				     &chan->dev);
-	if(fd < 0) return(fd);
+	if(chan->opened)
+		return 0;
+
+	if(chan->ops->open == NULL)
+		fd = 0;
+	else fd = (*chan->ops->open)(chan->input, chan->output, chan->primary,
+				     chan->data, &chan->dev);
+	if(fd < 0)
+		return fd;
 	chan->fd = fd;
 
 	chan->opened = 1;
-	return(0);
+	return 0;
 }
 
 int open_chan(struct list_head *chans)
@@ -215,11 +219,11 @@ int open_chan(struct list_head *chans)
 
 	list_for_each(ele, chans){
 		chan = list_entry(ele, struct chan, list);
-		ret = open_one_chan(chan, chan->input, chan->output,
-				    chan->primary);
-		if(chan->primary) err = ret;
+		ret = open_one_chan(chan);
+		if(chan->primary)
+			err = ret;
 	}
-	return(err);
+	return err;
 }
 
 void chan_enable_winch(struct list_head *chans, struct tty_struct *tty)
@@ -267,7 +271,7 @@ void close_chan(struct list_head *chans)
 	}
 }
 
-int write_chan(struct list_head *chans, const char *buf, int len, 
+int write_chan(struct list_head *chans, const char *buf, int len,
 	       int write_irq)
 {
 	struct list_head *ele;
@@ -285,7 +289,7 @@ int write_chan(struct list_head *chans, 
 				reactivate_fd(chan->fd, write_irq);
 		}
 	}
-	return(ret);
+	return ret;
 }
 
 int console_write_chan(struct list_head *chans, const char *buf, int len)
@@ -301,10 +305,11 @@ int console_write_chan(struct list_head 
 		n = chan->ops->console_write(chan->fd, buf, len);
 		if(chan->primary) ret = n;
 	}
-	return(ret);
+	return ret;
 }
 
-int console_open_chan(struct line *line, struct console *co, struct chan_opts *opts)
+int console_open_chan(struct line *line, struct console *co,
+		      struct chan_opts *opts)
 {
 	if (!list_empty(&line->chan_list))
 		return 0;
@@ -327,12 +332,13 @@ int chan_window_size(struct list_head *c
 	list_for_each(ele, chans){
 		chan = list_entry(ele, struct chan, list);
 		if(chan->primary){
-			if(chan->ops->window_size == NULL) return(0);
-			return(chan->ops->window_size(chan->fd, chan->data,
-						      rows_out, cols_out));
+			if(chan->ops->window_size == NULL)
+				return 0;
+			return chan->ops->window_size(chan->fd, chan->data,
+						      rows_out, cols_out);
 		}
 	}
-	return(0);
+	return 0;
 }
 
 void free_one_chan(struct chan *chan)
@@ -363,23 +369,23 @@ static int one_chan_config_string(struct
 
 	if(chan == NULL){
 		CONFIG_CHUNK(str, size, n, "none", 1);
-		return(n);
+		return n;
 	}
 
 	CONFIG_CHUNK(str, size, n, chan->ops->type, 0);
 
 	if(chan->dev == NULL){
 		CONFIG_CHUNK(str, size, n, "", 1);
-		return(n);
+		return n;
 	}
 
 	CONFIG_CHUNK(str, size, n, ":", 0);
 	CONFIG_CHUNK(str, size, n, chan->dev, 0);
 
-	return(n);
+	return n;
 }
 
-static int chan_pair_config_string(struct chan *in, struct chan *out, 
+static int chan_pair_config_string(struct chan *in, struct chan *out,
 				   char *str, int size, char **error_out)
 {
 	int n;
@@ -390,7 +396,7 @@ static int chan_pair_config_string(struc
 
 	if(in == out){
 		CONFIG_CHUNK(str, size, n, "", 1);
-		return(n);
+		return n;
 	}
 
 	CONFIG_CHUNK(str, size, n, ",", 1);
@@ -399,10 +405,10 @@ static int chan_pair_config_string(struc
 	size -= n;
 	CONFIG_CHUNK(str, size, n, "", 1);
 
-	return(n);
+	return n;
 }
 
-int chan_config_string(struct list_head *chans, char *str, int size, 
+int chan_config_string(struct list_head *chans, char *str, int size,
 		       char **error_out)
 {
 	struct list_head *ele;
@@ -418,7 +424,7 @@ int chan_config_string(struct list_head 
 			out = chan;
 	}
 
-	return(chan_pair_config_string(in, out, str, size, error_out));
+	return chan_pair_config_string(in, out, str, size, error_out);
 }
 
 struct chan_type {
@@ -462,7 +468,7 @@ struct chan_type chan_table[] = {
 #endif
 };
 
-static struct chan *parse_chan(char *str, int pri, int device, 
+static struct chan *parse_chan(char *str, int pri, int device,
 			       struct chan_opts *opts)
 {
 	struct chan_type *entry;
@@ -484,14 +490,17 @@ static struct chan *parse_chan(char *str
 	if(ops == NULL){
 		my_printf("parse_chan couldn't parse \"%s\"\n",
 		       str);
-		return(NULL);
+		return NULL;
 	}
-	if(ops->init == NULL) return(NULL); 
+	if(ops->init == NULL)
+		return NULL;
 	data = (*ops->init)(str, device, opts);
-	if(data == NULL) return(NULL);
+	if(data == NULL)
+		return NULL;
 
 	chan = kmalloc(sizeof(*chan), GFP_ATOMIC);
-	if(chan == NULL) return(NULL);
+	if(chan == NULL)
+		return NULL;
 	*chan = ((struct chan) { .list	 	= LIST_HEAD_INIT(chan->list),
 				 .primary	= 1,
 				 .input		= 0,
@@ -501,7 +510,7 @@ static struct chan *parse_chan(char *str
 				 .pri 		= pri,
 				 .ops 		= ops,
 				 .data 		= data });
-	return(chan);
+	return chan;
 }
 
 int parse_chan_pair(char *str, struct list_head *chans, int pri, int device,
@@ -512,7 +521,8 @@ int parse_chan_pair(char *str, struct li
 
 	if(!list_empty(chans)){
 		chan = list_entry(chans->next, struct chan, list);
-		if(chan->pri >= pri) return(0);
+		if(chan->pri >= pri)
+			return 0;
 		free_chan(chans);
 		INIT_LIST_HEAD(chans);
 	}
@@ -523,23 +533,29 @@ int parse_chan_pair(char *str, struct li
 		*out = '\0';
 		out++;
 		new = parse_chan(in, pri, device, opts);
-		if(new == NULL) return(-1);
+		if(new == NULL)
+			return -1;
+
 		new->input = 1;
 		list_add(&new->list, chans);
 
 		new = parse_chan(out, pri, device, opts);
-		if(new == NULL) return(-1);
+		if(new == NULL)
+			return -1;
+
 		list_add(&new->list, chans);
 		new->output = 1;
 	}
 	else {
 		new = parse_chan(str, pri, device, opts);
-		if(new == NULL) return(-1);
+		if(new == NULL)
+			return -1;
+
 		list_add(&new->list, chans);
 		new->input = 1;
 		new->output = 1;
 	}
-	return(0);
+	return 0;
 }
 
 int chan_out_fd(struct list_head *chans)
@@ -550,9 +566,9 @@ int chan_out_fd(struct list_head *chans)
 	list_for_each(ele, chans){
 		chan = list_entry(ele, struct chan, list);
 		if(chan->primary && chan->output)
-			return(chan->fd);
+			return chan->fd;
 	}
-	return(-1);
+	return -1;
 }
 
 void chan_interrupt(struct list_head *chans, struct work_struct *task,
@@ -567,7 +583,7 @@ void chan_interrupt(struct list_head *ch
 		chan = list_entry(ele, struct chan, list);
 		if(!chan->input || (chan->ops->read == NULL)) continue;
 		do {
-			if((tty != NULL) && 
+			if((tty != NULL) &&
 			   (tty->flip.count >= TTY_FLIPBUF_SIZE)){
 				schedule_work(task);
 				goto out;
Index: linux-2.6.15/arch/um/drivers/line.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/line.c	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/line.c	2006-01-03 17:28:46.000000000 -0500
@@ -124,7 +124,8 @@ static int buffer_data(struct line *line
 	if (len < end){
 		memcpy(line->tail, buf, len);
 		line->tail += len;
-	} else {
+	}
+	else {
 		/* The circular buffer is wrapping */
 		memcpy(line->tail, buf, end);
 		buf += end;
@@ -170,7 +171,7 @@ static int flush_buffer(struct line *lin
 	}
 
 	count = line->tail - line->head;
-	n = write_chan(&line->chan_list, line->head, count, 
+	n = write_chan(&line->chan_list, line->head, count,
 		       line->driver->write_irq);
 
 	if(n < 0)
@@ -227,7 +228,7 @@ int line_write(struct tty_struct *tty, c
 		if (err <= 0 && (err != -EAGAIN || !ret))
 			ret = err;
 	} else {
-		n = write_chan(&line->chan_list, buf, len, 
+		n = write_chan(&line->chan_list, buf, len,
 			       line->driver->write_irq);
 		if (n < 0) {
 			ret = n;
@@ -384,13 +385,13 @@ int line_setup_irq(int fd, int input, in
 
 	if (input)
 		err = um_request_irq(driver->read_irq, fd, IRQ_READ,
-				       line_interrupt, flags, 
+				       line_interrupt, flags,
 				       driver->read_irq_name, tty);
 	if (err)
 		return err;
 	if (output)
 		err = um_request_irq(driver->write_irq, fd, IRQ_WRITE,
-					line_write_interrupt, flags, 
+					line_write_interrupt, flags,
 					driver->write_irq_name, tty);
 	line->have_irq = 1;
 	return err;
@@ -512,10 +513,11 @@ int line_setup(struct line *lines, unsig
 		/* We said con=/ssl= instead of con#=, so we are configuring all
 		 * consoles at once.*/
 		n = -1;
-	} else {
+	}
+	else {
 		n = simple_strtoul(init, &end, 0);
 		if(*end != '='){
-			printk(KERN_ERR "line_setup failed to parse \"%s\"\n", 
+			printk(KERN_ERR "line_setup failed to parse \"%s\"\n",
 			       init);
 			return 0;
 		}
@@ -527,7 +529,8 @@ int line_setup(struct line *lines, unsig
 		printk("line_setup - %d out of range ((0 ... %d) allowed)\n",
 		       n, num - 1);
 		return 0;
-	} else if (n >= 0){
+	}
+	else if (n >= 0){
 		if (lines[n].count > 0) {
 			printk("line_setup - device %d is open\n", n);
 			return 0;
@@ -541,11 +544,13 @@ int line_setup(struct line *lines, unsig
 				lines[n].valid = 1;
 			}	
 		}
-	} else if(!all_allowed){
+	}
+	else if(!all_allowed){
 		printk("line_setup - can't configure all devices from "
 		       "mconsole\n");
 		return 0;
-	} else {
+	}
+	else {
 		for(i = 0; i < num; i++){
 			if(lines[i].init_pri <= INIT_ALL){
 				lines[i].init_pri = INIT_ALL;
@@ -627,7 +632,7 @@ int line_remove(struct line *lines, unsi
 }
 
 struct tty_driver *line_register_devfs(struct lines *set,
-			 struct line_driver *line_driver, 
+			 struct line_driver *line_driver,
 			 struct tty_operations *ops, struct line *lines,
 			 int nlines)
 {
@@ -656,7 +661,7 @@ struct tty_driver *line_register_devfs(s
 	}
 
 	for(i = 0; i < nlines; i++){
-		if(!lines[i].valid) 
+		if(!lines[i].valid)
 			tty_unregister_device(driver, i);
 	}
 
@@ -677,11 +682,12 @@ void lines_init(struct line *lines, int 
 		line = &lines[i];
 		INIT_LIST_HEAD(&line->chan_list);
 		spin_lock_init(&line->lock);
-		if(line->init_str != NULL){
-			line->init_str = kstrdup(line->init_str, GFP_KERNEL);
-			if(line->init_str == NULL)
-				printk("lines_init - kstrdup returned NULL\n");
-		}
+		if(line->init_str == NULL)
+			continue;
+
+		line->init_str = kstrdup(line->init_str, GFP_KERNEL);
+		if(line->init_str == NULL)
+			printk("lines_init - kstrdup returned NULL\n");
 	}
 }
 
@@ -717,8 +723,7 @@ irqreturn_t winch_interrupt(int irq, voi
 	tty  = winch->tty;
 	if (tty != NULL) {
 		line = tty->driver_data;
-		chan_window_size(&line->chan_list,
-				 &tty->winsize.ws_row, 
+		chan_window_size(&line->chan_list, &tty->winsize.ws_row,
 				 &tty->winsize.ws_col);
 		kill_pg(tty->pgrp, SIGWINCH, 1);
 	}
@@ -749,7 +754,7 @@ void register_winch_irq(int fd, int tty_
 	spin_unlock(&winch_handler_lock);
 
 	if(um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
-			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM, 
+			  SA_INTERRUPT | SA_SHIRQ | SA_SAMPLE_RANDOM,
 			  "winch", winch) < 0)
 		printk("register_winch_irq - failed to register IRQ\n");
 }
@@ -800,7 +805,7 @@ static void winch_cleanup(void)
 			deactivate_fd(winch->fd, WINCH_IRQ);
 			os_close_file(winch->fd);
 		}
-		if(winch->pid != -1) 
+		if(winch->pid != -1)
 			os_kill_process(winch->pid, 1);
 	}
 }
Index: linux-2.6.15/arch/um/drivers/ssl.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/ssl.c	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/ssl.c	2006-01-03 17:28:00.000000000 -0500
@@ -69,7 +69,7 @@ static struct line_driver driver = {
 		.name  		= "ssl",
 		.config 	= ssl_config,
 		.get_config 	= ssl_get_config,
-                .id		= line_id,
+		.id		= line_id,
 		.remove 	= ssl_remove,
 	},
 };
@@ -84,21 +84,21 @@ static struct lines lines = LINES_INIT(N
 
 static int ssl_config(char *str)
 {
-	return(line_config(serial_lines, 
-			   sizeof(serial_lines)/sizeof(serial_lines[0]), str));
+	return line_config(serial_lines,
+			   sizeof(serial_lines)/sizeof(serial_lines[0]), str);
 }
 
 static int ssl_get_config(char *dev, char *str, int size, char **error_out)
 {
-	return(line_get_config(dev, serial_lines, 
-			       sizeof(serial_lines)/sizeof(serial_lines[0]), 
-			       str, size, error_out));
+	return line_get_config(dev, serial_lines,
+			       sizeof(serial_lines)/sizeof(serial_lines[0]),
+			       str, size, error_out);
 }
 
 static int ssl_remove(int n)
 {
-        return line_remove(serial_lines,
-                           sizeof(serial_lines)/sizeof(serial_lines[0]), n);
+	return line_remove(serial_lines,
+			   sizeof(serial_lines)/sizeof(serial_lines[0]), n);
 }
 
 int ssl_open(struct tty_struct *tty, struct file *filp)
@@ -183,7 +183,7 @@ static int ssl_console_setup(struct cons
 {
 	struct line *line = &serial_lines[co->index];
 
-	return console_open_chan(line,co,&opts);
+	return console_open_chan(line, co, &opts);
 }
 
 static struct console ssl_cons = {
@@ -199,10 +199,11 @@ int ssl_init(void)
 {
 	char *new_title;
 
-	printk(KERN_INFO "Initializing software serial port version %d\n", 
+	printk(KERN_INFO "Initializing software serial port version %d\n",
 	       ssl_version);
 	ssl_driver = line_register_devfs(&lines, &driver, &ssl_ops,
-					 serial_lines, ARRAY_SIZE(serial_lines));
+					 serial_lines,
+					 ARRAY_SIZE(serial_lines));
 
 	lines_init(serial_lines, sizeof(serial_lines)/sizeof(serial_lines[0]));
 
@@ -212,7 +213,7 @@ int ssl_init(void)
 
 	ssl_init_done = 1;
 	register_console(&ssl_cons);
-	return(0);
+	return 0;
 }
 late_initcall(ssl_init);
 
@@ -227,9 +228,9 @@ __uml_exitcall(ssl_exit);
 
 static int ssl_chan_setup(char *str)
 {
-	return(line_setup(serial_lines,
+	return line_setup(serial_lines,
 			  sizeof(serial_lines)/sizeof(serial_lines[0]),
-			  str, 1));
+			  str, 1);
 }
 
 __setup("ssl", ssl_chan_setup);
Index: linux-2.6.15/arch/um/drivers/stdio_console.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/stdio_console.c	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/stdio_console.c	2006-01-03 17:28:00.000000000 -0500
@@ -75,7 +75,7 @@ static struct line_driver driver = {
 		.name  		= "con",
 		.config 	= con_config,
 		.get_config 	= con_get_config,
-                .id		= line_id,
+		.id		= line_id,
 		.remove 	= con_remove,
 	},
 };
@@ -86,23 +86,23 @@ static struct lines console_lines = LINE
  * individual elements are protected by individual semaphores.
  */
 struct line vts[MAX_TTYS] = { LINE_INIT(CONFIG_CON_ZERO_CHAN, &driver),
-			      [ 1 ... MAX_TTYS - 1 ] = 
+			      [ 1 ... MAX_TTYS - 1 ] =
 			      LINE_INIT(CONFIG_CON_CHAN, &driver) };
 
 static int con_config(char *str)
 {
-	return(line_config(vts, sizeof(vts)/sizeof(vts[0]), str));
+	return line_config(vts, sizeof(vts)/sizeof(vts[0]), str);
 }
 
 static int con_get_config(char *dev, char *str, int size, char **error_out)
 {
-	return(line_get_config(dev, vts, sizeof(vts)/sizeof(vts[0]), str, 
-			       size, error_out));
+	return line_get_config(dev, vts, sizeof(vts)/sizeof(vts[0]), str,
+			       size, error_out);
 }
 
 static int con_remove(int n)
 {
-        return line_remove(vts, sizeof(vts)/sizeof(vts[0]), n);
+	return line_remove(vts, sizeof(vts)/sizeof(vts[0]), n);
 }
 
 static int con_open(struct tty_struct *tty, struct file *filp)
@@ -117,7 +117,7 @@ static struct tty_operations console_ops
 	.close 	 		= line_close,
 	.write 	 		= line_write,
 	.put_char 		= line_put_char,
- 	.write_room		= line_write_room,
+	.write_room		= line_write_room,
 	.chars_in_buffer 	= line_chars_in_buffer,
 	.flush_buffer 		= line_flush_buffer,
 	.flush_chars 		= line_flush_chars,
@@ -126,7 +126,7 @@ static struct tty_operations console_ops
 };
 
 static void uml_console_write(struct console *console, const char *string,
-			  unsigned len)
+			      unsigned len)
 {
 	struct line *line = &vts[console->index];
 	unsigned long flags;
@@ -146,7 +146,7 @@ static int uml_console_setup(struct cons
 {
 	struct line *line = &vts[co->index];
 
-	return console_open_chan(line,co,&opts);
+	return console_open_chan(line, co, &opts);
 }
 
 static struct console stdiocons = {
@@ -156,7 +156,7 @@ static struct console stdiocons = {
 	.setup		= uml_console_setup,
 	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
-	.data           = &vts,
+	.data		= &vts,
 };
 
 int stdio_init(void)
@@ -166,7 +166,7 @@ int stdio_init(void)
 	console_driver = line_register_devfs(&console_lines, &driver,
 					     &console_ops, vts,
 					     ARRAY_SIZE(vts));
-	if (NULL == console_driver)
+	if (console_driver == NULL)
 		return -1;
 	printk(KERN_INFO "Initialized stdio console driver\n");
 
@@ -178,7 +178,7 @@ int stdio_init(void)
 
 	con_init_done = 1;
 	register_console(&stdiocons);
-	return(0);
+	return 0;
 }
 late_initcall(stdio_init);
 
@@ -192,7 +192,7 @@ __uml_exitcall(console_exit);
 
 static int console_chan_setup(char *str)
 {
-	return(line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1));
+	return line_setup(vts, sizeof(vts)/sizeof(vts[0]), str, 1);
 }
 __setup("con", console_chan_setup);
 __channel_help(console_chan_setup, "con");
Index: linux-2.6.15/arch/um/include/chan_kern.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/chan_kern.h	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/include/chan_kern.h	2006-01-03 17:28:00.000000000 -0500
@@ -47,14 +47,3 @@ extern int chan_config_string(struct lis
 			      char **error_out);
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15/arch/um/include/line.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/line.h	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/include/line.h	2006-01-03 17:28:00.000000000 -0500
@@ -64,8 +64,8 @@ struct line {
 	  head :	NULL, \
 	  tail :	NULL, \
 	  sigio :	0, \
- 	  driver :	d, \
-          have_irq :	0 }
+	  driver :	d, \
+	  have_irq :	0 }
 
 struct lines {
 	int num;
@@ -74,11 +74,12 @@ struct lines {
 #define LINES_INIT(n) {  num :		n }
 
 extern void line_close(struct tty_struct *tty, struct file * filp);
-extern int line_open(struct line *lines, struct tty_struct *tty, 
+extern int line_open(struct line *lines, struct tty_struct *tty,
 		     struct chan_opts *opts);
 extern int line_setup(struct line *lines, unsigned int sizeof_lines, char *init,
 		      int all_allowed);
-extern int line_write(struct tty_struct *tty, const unsigned char *buf, int len);
+extern int line_write(struct tty_struct *tty, const unsigned char *buf,
+		      int len);
 extern void line_put_char(struct tty_struct *tty, unsigned char ch);
 extern void line_set_termios(struct tty_struct *tty, struct termios * old);
 extern int line_chars_in_buffer(struct tty_struct *tty);
@@ -89,21 +90,24 @@ extern int line_ioctl(struct tty_struct 
 		      unsigned int cmd, unsigned long arg);
 
 extern char *add_xterm_umid(char *base);
-extern int line_setup_irq(int fd, int input, int output, struct tty_struct *tty);
+extern int line_setup_irq(int fd, int input, int output,
+			  struct tty_struct *tty);
 extern void line_close_chan(struct line *line);
 extern void line_disable(struct tty_struct *tty, int current_irq);
-extern struct tty_driver * line_register_devfs(struct lines *set, 
-				struct line_driver *line_driver, 
+extern struct tty_driver * line_register_devfs(struct lines *set,
+				struct line_driver *line_driver,
 				struct tty_operations *driver,
 				struct line *lines,
 				int nlines);
 extern void lines_init(struct line *lines, int nlines);
 extern void close_lines(struct line *lines, int nlines);
 
-extern int line_config(struct line *lines, unsigned int sizeof_lines, char *str);
+extern int line_config(struct line *lines, unsigned int sizeof_lines,
+		       char *str);
 extern int line_id(char **str, int *start_out, int *end_out);
 extern int line_remove(struct line *lines, unsigned int sizeof_lines, int n);
-extern int line_get_config(char *dev, struct line *lines, unsigned int sizeof_lines, char *str,
+extern int line_get_config(char *dev, struct line *lines,
+			   unsigned int sizeof_lines, char *str,
 			   int size, char **error_out);
 
 #endif
Index: linux-2.6.15/arch/um/os-Linux/aio.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/aio.c	2006-01-03 17:19:44.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/aio.c	2006-01-03 17:20:06.000000000 -0500
@@ -16,12 +16,12 @@
 #include "mode.h"
 
 struct aio_thread_req {
-        enum aio_type type;
-        int io_fd;
-        unsigned long long offset;
-        char *buf;
-        int len;
-        struct aio_context *aio;
+	enum aio_type type;
+	int io_fd;
+	unsigned long long offset;
+	char *buf;
+	int len;
+	struct aio_context *aio;
 };
 
 static int aio_req_fd_r = -1;
@@ -38,18 +38,18 @@ static int aio_req_fd_w = -1;
 
 static long io_setup(int n, aio_context_t *ctxp)
 {
-        return syscall(__NR_io_setup, n, ctxp);
+	return syscall(__NR_io_setup, n, ctxp);
 }
 
 static long io_submit(aio_context_t ctx, long nr, struct iocb **iocbpp)
 {
-        return syscall(__NR_io_submit, ctx, nr, iocbpp);
+	return syscall(__NR_io_submit, ctx, nr, iocbpp);
 }
 
 static long io_getevents(aio_context_t ctx_id, long min_nr, long nr,
-                         struct io_event *events, struct timespec *timeout)
+			 struct io_event *events, struct timespec *timeout)
 {
-        return syscall(__NR_io_getevents, ctx_id, min_nr, nr, events, timeout);
+	return syscall(__NR_io_getevents, ctx_id, min_nr, nr, events, timeout);
 }
 
 #endif
@@ -66,150 +66,150 @@ static long io_getevents(aio_context_t c
  */
 
 static int do_aio(aio_context_t ctx, enum aio_type type, int fd, char *buf,
-                  int len, unsigned long long offset, struct aio_context *aio)
+		  int len, unsigned long long offset, struct aio_context *aio)
 {
-        struct iocb iocb, *iocbp = &iocb;
-        char c;
-        int err;
-
-        iocb = ((struct iocb) { .aio_data 	= (unsigned long) aio,
-                                .aio_reqprio	= 0,
-                                .aio_fildes	= fd,
-                                .aio_buf	= (unsigned long) buf,
-                                .aio_nbytes	= len,
-                                .aio_offset	= offset,
-                                .aio_reserved1	= 0,
-                                .aio_reserved2	= 0,
-                                .aio_reserved3	= 0 });
-
-        switch(type){
-        case AIO_READ:
-                iocb.aio_lio_opcode = IOCB_CMD_PREAD;
-                err = io_submit(ctx, 1, &iocbp);
-                break;
-        case AIO_WRITE:
-                iocb.aio_lio_opcode = IOCB_CMD_PWRITE;
-                err = io_submit(ctx, 1, &iocbp);
-                break;
-        case AIO_MMAP:
-                iocb.aio_lio_opcode = IOCB_CMD_PREAD;
-                iocb.aio_buf = (unsigned long) &c;
-                iocb.aio_nbytes = sizeof(c);
-                err = io_submit(ctx, 1, &iocbp);
-                break;
-        default:
-                printk("Bogus op in do_aio - %d\n", type);
-                err = -EINVAL;
-                break;
-        }
+	struct iocb iocb, *iocbp = &iocb;
+	char c;
+	int err;
+
+	iocb = ((struct iocb) { .aio_data 	= (unsigned long) aio,
+				.aio_reqprio	= 0,
+				.aio_fildes	= fd,
+				.aio_buf	= (unsigned long) buf,
+				.aio_nbytes	= len,
+				.aio_offset	= offset,
+				.aio_reserved1	= 0,
+				.aio_reserved2	= 0,
+				.aio_reserved3	= 0 });
+
+	switch(type){
+	case AIO_READ:
+		iocb.aio_lio_opcode = IOCB_CMD_PREAD;
+		err = io_submit(ctx, 1, &iocbp);
+		break;
+	case AIO_WRITE:
+		iocb.aio_lio_opcode = IOCB_CMD_PWRITE;
+		err = io_submit(ctx, 1, &iocbp);
+		break;
+	case AIO_MMAP:
+		iocb.aio_lio_opcode = IOCB_CMD_PREAD;
+		iocb.aio_buf = (unsigned long) &c;
+		iocb.aio_nbytes = sizeof(c);
+		err = io_submit(ctx, 1, &iocbp);
+		break;
+	default:
+		printk("Bogus op in do_aio - %d\n", type);
+		err = -EINVAL;
+		break;
+	}
 
-        if(err > 0)
-                err = 0;
+	if(err > 0)
+		err = 0;
 	else
 		err = -errno;
 
-        return err;
+	return err;
 }
 
 static aio_context_t ctx = 0;
 
 static int aio_thread(void *arg)
 {
-        struct aio_thread_reply reply;
-        struct io_event event;
-        int err, n, reply_fd;
-
-        signal(SIGWINCH, SIG_IGN);
-
-        while(1){
-                n = io_getevents(ctx, 1, 1, &event, NULL);
-                if(n < 0){
-                        if(errno == EINTR)
-                                continue;
-                        printk("aio_thread - io_getevents failed, "
-                               "errno = %d\n", errno);
-                }
-                else {
-                        reply = ((struct aio_thread_reply)
-				 { .data = (void *) (long) event.data,
-				   .err	= event.res });
+	struct aio_thread_reply reply;
+	struct io_event event;
+	int err, n, reply_fd;
+
+	signal(SIGWINCH, SIG_IGN);
+
+	while(1){
+		n = io_getevents(ctx, 1, 1, &event, NULL);
+		if(n < 0){
+			if(errno == EINTR)
+				continue;
+			printk("aio_thread - io_getevents failed, "
+			       "errno = %d\n", errno);
+		}
+		else {
+			reply = ((struct aio_thread_reply)
+				{ .data = (void *) (long) event.data,
+						.err	= event.res });
 			reply_fd = ((struct aio_context *) reply.data)->reply_fd;
 			err = os_write_file(reply_fd, &reply, sizeof(reply));
-                        if(err != sizeof(reply))
+			if(err != sizeof(reply))
 				printk("aio_thread - write failed, fd = %d, "
-                                       "err = %d\n", aio_req_fd_r, -err);
-                }
-        }
-        return 0;
+				       "err = %d\n", aio_req_fd_r, -err);
+		}
+	}
+	return 0;
 }
 
 #endif
 
 static int do_not_aio(struct aio_thread_req *req)
 {
-        char c;
-        int err;
+	char c;
+	int err;
 
-        switch(req->type){
-        case AIO_READ:
-                err = os_seek_file(req->io_fd, req->offset);
-                if(err)
-                        goto out;
-
-                err = os_read_file(req->io_fd, req->buf, req->len);
-                break;
-        case AIO_WRITE:
-                err = os_seek_file(req->io_fd, req->offset);
-                if(err)
-                        goto out;
-
-                err = os_write_file(req->io_fd, req->buf, req->len);
-                break;
-        case AIO_MMAP:
-                err = os_seek_file(req->io_fd, req->offset);
-                if(err)
-                        goto out;
-
-                err = os_read_file(req->io_fd, &c, sizeof(c));
-                break;
-        default:
-                printk("do_not_aio - bad request type : %d\n", req->type);
-                err = -EINVAL;
-                break;
-        }
+	switch(req->type){
+	case AIO_READ:
+		err = os_seek_file(req->io_fd, req->offset);
+		if(err)
+			goto out;
+
+		err = os_read_file(req->io_fd, req->buf, req->len);
+		break;
+	case AIO_WRITE:
+		err = os_seek_file(req->io_fd, req->offset);
+		if(err)
+			goto out;
+
+		err = os_write_file(req->io_fd, req->buf, req->len);
+		break;
+	case AIO_MMAP:
+		err = os_seek_file(req->io_fd, req->offset);
+		if(err)
+			goto out;
+
+		err = os_read_file(req->io_fd, &c, sizeof(c));
+		break;
+	default:
+		printk("do_not_aio - bad request type : %d\n", req->type);
+		err = -EINVAL;
+		break;
+	}
 
- out:
-        return err;
+out:
+	return err;
 }
 
 static int not_aio_thread(void *arg)
 {
-        struct aio_thread_req req;
-        struct aio_thread_reply reply;
-        int err;
-
-        signal(SIGWINCH, SIG_IGN);
-        while(1){
-                err = os_read_file(aio_req_fd_r, &req, sizeof(req));
-                if(err != sizeof(req)){
-                        if(err < 0)
-                                printk("not_aio_thread - read failed, "
-                                       "fd = %d, err = %d\n", aio_req_fd_r,
-                                       -err);
-                        else {
-                                printk("not_aio_thread - short read, fd = %d, "
-                                       "length = %d\n", aio_req_fd_r, err);
-                        }
-                        continue;
-                }
-                err = do_not_aio(&req);
-                reply = ((struct aio_thread_reply) { .data 	= req.aio,
-                                                     .err	= err });
-                err = os_write_file(req.aio->reply_fd, &reply, sizeof(reply));
-                if(err != sizeof(reply))
-                        printk("not_aio_thread - write failed, fd = %d, "
-                               "err = %d\n", aio_req_fd_r, -err);
-        }
+	struct aio_thread_req req;
+	struct aio_thread_reply reply;
+	int err;
+
+	signal(SIGWINCH, SIG_IGN);
+	while(1){
+		err = os_read_file(aio_req_fd_r, &req, sizeof(req));
+		if(err != sizeof(req)){
+			if(err < 0)
+				printk("not_aio_thread - read failed, "
+				       "fd = %d, err = %d\n", aio_req_fd_r,
+				       -err);
+			else {
+				printk("not_aio_thread - short read, fd = %d, "
+				       "length = %d\n", aio_req_fd_r, err);
+			}
+			continue;
+		}
+		err = do_not_aio(&req);
+		reply = ((struct aio_thread_reply) { .data 	= req.aio,
+					 .err	= err });
+		err = os_write_file(req.aio->reply_fd, &reply, sizeof(reply));
+		if(err != sizeof(reply))
+			printk("not_aio_thread - write failed, fd = %d, "
+			       "err = %d\n", aio_req_fd_r, -err);
+	}
 
 	return 0;
 }
@@ -218,93 +218,93 @@ static int aio_pid = -1;
 
 static int init_aio_24(void)
 {
-        unsigned long stack;
-        int fds[2], err;
+	unsigned long stack;
+	int fds[2], err;
 
-        err = os_pipe(fds, 1, 1);
-        if(err)
-                goto out;
-
-        aio_req_fd_w = fds[0];
-        aio_req_fd_r = fds[1];
-        err = run_helper_thread(not_aio_thread, NULL,
-                                CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
-        if(err < 0)
-                goto out_close_pipe;
-
-        aio_pid = err;
-        goto out;
-
- out_close_pipe:
-        os_close_file(fds[0]);
-        os_close_file(fds[1]);
-        aio_req_fd_w = -1;
-        aio_req_fd_r = -1;
- out:
+	err = os_pipe(fds, 1, 1);
+	if(err)
+		goto out;
+
+	aio_req_fd_w = fds[0];
+	aio_req_fd_r = fds[1];
+	err = run_helper_thread(not_aio_thread, NULL,
+				CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
+	if(err < 0)
+		goto out_close_pipe;
+
+	aio_pid = err;
+	goto out;
+
+out_close_pipe:
+	os_close_file(fds[0]);
+	os_close_file(fds[1]);
+	aio_req_fd_w = -1;
+	aio_req_fd_r = -1;
+out:
 #ifndef HAVE_AIO_ABI
 	printk("/usr/include/linux/aio_abi.h not present during build\n");
 #endif
 	printk("2.6 host AIO support not used - falling back to I/O "
 	       "thread\n");
-        return 0;
+	return 0;
 }
 
 #ifdef HAVE_AIO_ABI
 #define DEFAULT_24_AIO 0
 static int init_aio_26(void)
 {
-        unsigned long stack;
-        int err;
+	unsigned long stack;
+	int err;
 
-        if(io_setup(256, &ctx)){
+	if(io_setup(256, &ctx)){
 		err = -errno;
-                printk("aio_thread failed to initialize context, err = %d\n",
-                       errno);
-                return err;
-        }
-
-        err = run_helper_thread(aio_thread, NULL,
-                                CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
-        if(err < 0)
-                return err;
+		printk("aio_thread failed to initialize context, err = %d\n",
+		       errno);
+		return err;
+	}
+
+	err = run_helper_thread(aio_thread, NULL,
+				CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
+	if(err < 0)
+		return err;
 
-        aio_pid = err;
+	aio_pid = err;
 
 	printk("Using 2.6 host AIO\n");
-        return 0;
+	return 0;
 }
 
 static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len,
 			 unsigned long long offset, struct aio_context *aio)
 {
-        struct aio_thread_reply reply;
-        int err;
+	struct aio_thread_reply reply;
+	int err;
 
-        err = do_aio(ctx, type, io_fd, buf, len, offset, aio);
-        if(err){
-                reply = ((struct aio_thread_reply) { .data = aio,
-                                                     .err  = err });
-                err = os_write_file(aio->reply_fd, &reply, sizeof(reply));
-                if(err != sizeof(reply))
-                        printk("submit_aio_26 - write failed, "
-                               "fd = %d, err = %d\n", aio->reply_fd, -err);
-                else err = 0;
-        }
+	err = do_aio(ctx, type, io_fd, buf, len, offset, aio);
+	if(err){
+		reply = ((struct aio_thread_reply) { .data = aio,
+					 .err  = err });
+		err = os_write_file(aio->reply_fd, &reply, sizeof(reply));
+		if(err != sizeof(reply))
+			printk("submit_aio_26 - write failed, "
+			       "fd = %d, err = %d\n", aio->reply_fd, -err);
+		else err = 0;
+	}
 
-        return err;
+	return err;
 }
 
 #else
 #define DEFAULT_24_AIO 1
 static int init_aio_26(void)
 {
-        return -ENOSYS;
+	return -ENOSYS;
 }
 
 static int submit_aio_26(enum aio_type type, int io_fd, char *buf, int len,
 			 unsigned long long offset, struct aio_context *aio)
 {
-        return -ENOSYS;
+	return -ENOSYS;
 }
 #endif
 
@@ -312,8 +312,8 @@ static int aio_24 = DEFAULT_24_AIO;
 
 static int __init set_aio_24(char *name, int *add)
 {
-        aio_24 = 1;
-        return 0;
+	aio_24 = 1;
+	return 0;
 }
 
 __uml_setup("aio=2.4", set_aio_24,
@@ -330,28 +330,27 @@ __uml_setup("aio=2.4", set_aio_24,
 
 static int init_aio(void)
 {
-        int err;
+	int err;
 
-        CHOOSE_MODE(({
-                if(!aio_24){
-                        printk("Disabling 2.6 AIO in tt mode\n");
-                        aio_24 = 1;
-                } }), (void) 0);
-
-        if(!aio_24){
-                err = init_aio_26();
-                if(err && (errno == ENOSYS)){
-                        printk("2.6 AIO not supported on the host - "
-                               "reverting to 2.4 AIO\n");
-                        aio_24 = 1;
-                }
-                else return err;
-        }
+	CHOOSE_MODE(({ if(!aio_24){
+			    printk("Disabling 2.6 AIO in tt mode\n");
+			    aio_24 = 1;
+		    } }), (void) 0);
+
+	if(!aio_24){
+		err = init_aio_26();
+		if(err && (errno == ENOSYS)){
+			printk("2.6 AIO not supported on the host - "
+			       "reverting to 2.4 AIO\n");
+			aio_24 = 1;
+		}
+		else return err;
+	}
 
-        if(aio_24)
-                return init_aio_24();
+	if(aio_24)
+		return init_aio_24();
 
-        return 0;
+	return 0;
 }
 
 /* The reason for the __initcall/__uml_exitcall asymmetry is that init_aio
@@ -364,8 +363,8 @@ __initcall(init_aio);
 
 static void exit_aio(void)
 {
-        if(aio_pid != -1)
-                os_kill_process(aio_pid, 1);
+	if(aio_pid != -1)
+		os_kill_process(aio_pid, 1);
 }
 
 __uml_exitcall(exit_aio);
@@ -373,30 +372,30 @@ __uml_exitcall(exit_aio);
 static int submit_aio_24(enum aio_type type, int io_fd, char *buf, int len,
 			 unsigned long long offset, struct aio_context *aio)
 {
-        struct aio_thread_req req = { .type 		= type,
-                                      .io_fd		= io_fd,
-                                      .offset		= offset,
-                                      .buf		= buf,
-                                      .len		= len,
-                                      .aio		= aio,
-        };
-        int err;
-
-        err = os_write_file(aio_req_fd_w, &req, sizeof(req));
-        if(err == sizeof(req))
-                err = 0;
+	struct aio_thread_req req = { .type 		= type,
+				      .io_fd		= io_fd,
+				      .offset		= offset,
+				      .buf		= buf,
+				      .len		= len,
+				      .aio		= aio,
+	};
+	int err;
+
+	err = os_write_file(aio_req_fd_w, &req, sizeof(req));
+	if(err == sizeof(req))
+		err = 0;
 
-        return err;
+	return err;
 }
 
 int submit_aio(enum aio_type type, int io_fd, char *buf, int len,
-               unsigned long long offset, int reply_fd,
-               struct aio_context *aio)
+	       unsigned long long offset, int reply_fd,
+	       struct aio_context *aio)
 {
-        aio->reply_fd = reply_fd;
-        if(aio_24)
-                return submit_aio_24(type, io_fd, buf, len, offset, aio);
-        else {
-                return submit_aio_26(type, io_fd, buf, len, offset, aio);
-        }
+	aio->reply_fd = reply_fd;
+	if(aio_24)
+		return submit_aio_24(type, io_fd, buf, len, offset, aio);
+	else {
+		return submit_aio_26(type, io_fd, buf, len, offset, aio);
+	}
 }
Index: linux-2.6.15/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/mconsole_kern.c	2006-01-03 17:17:16.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/mconsole_kern.c	2006-01-03 17:28:28.000000000 -0500
@@ -34,7 +34,7 @@
 #include "irq_kern.h"
 #include "choose-mode.h"
 
-static int do_unlink_socket(struct notifier_block *notifier, 
+static int do_unlink_socket(struct notifier_block *notifier,
 			    unsigned long what, void *data)
 {
 	return(mconsole_unlink_socket());
@@ -46,7 +46,7 @@ static struct notifier_block reboot_noti
 	.priority		= 0,
 };
 
-/* Safe without explicit locking for now.  Tasklets provide their own 
+/* Safe without explicit locking for now.  Tasklets provide their own
  * locking, and the interrupt handler is safe because it can't interrupt
  * itself and it can only happen on CPU 0.
  */
@@ -60,7 +60,7 @@ static void mc_work_proc(void *unused)
 
 	while(!list_empty(&mc_requests)){
 		local_save_flags(flags);
-		req = list_entry(mc_requests.next, struct mconsole_entry, 
+		req = list_entry(mc_requests.next, struct mconsole_entry,
 				 list);
 		list_del(&req->list);
 		local_irq_restore(flags);
@@ -103,8 +103,8 @@ void mconsole_version(struct mc_request 
 {
 	char version[256];
 
-	sprintf(version, "%s %s %s %s %s", system_utsname.sysname, 
-		system_utsname.nodename, system_utsname.release, 
+	sprintf(version, "%s %s %s %s %s", system_utsname.sysname,
+		system_utsname.nodename, system_utsname.release,
 		system_utsname.version, system_utsname.machine);
 	mconsole_reply(req, version, 0, 0);
 }
@@ -348,7 +348,7 @@ static struct mc_device *mconsole_find_d
 
 #define CONFIG_BUF_SIZE 64
 
-static void mconsole_get_config(int (*get_config)(char *, char *, int, 
+static void mconsole_get_config(int (*get_config)(char *, char *, int,
 						  char **),
 				struct mc_request *req, char *name)
 {
@@ -389,7 +389,6 @@ static void mconsole_get_config(int (*ge
  out:
 	if(buf != default_buf)
 		kfree(buf);
-	
 }
 
 void mconsole_config(struct mc_request *req)
@@ -420,7 +419,7 @@ void mconsole_config(struct mc_request *
 
 void mconsole_remove(struct mc_request *req)
 {
-	struct mc_device *dev;	
+	struct mc_device *dev;
 	char *ptr = req->request.data, *err_msg = "";
         char error[256];
 	int err, start, end, n;
@@ -534,7 +533,7 @@ void mconsole_stack(struct mc_request *r
 /* Changed by mconsole_setup, which is __setup, and called before SMP is
  * active.
  */
-static char *notify_socket = NULL; 
+static char *notify_socket = NULL;
 
 int mconsole_init(void)
 {
@@ -566,13 +565,13 @@ int mconsole_init(void)
 		notify_socket = kstrdup(notify_socket, GFP_KERNEL);
 		if(notify_socket != NULL)
 			mconsole_notify(notify_socket, MCONSOLE_SOCKET,
-					mconsole_socket_name, 
+					mconsole_socket_name,
 					strlen(mconsole_socket_name) + 1);
 		else printk(KERN_ERR "mconsole_setup failed to strdup "
 			    "string\n");
 	}
 
-	printk("mconsole (version %d) initialized on %s\n", 
+	printk("mconsole (version %d) initialized on %s\n",
 	       MCONSOLE_VERSION, mconsole_socket_name);
 	return(0);
 }
@@ -585,7 +584,7 @@ static int write_proc_mconsole(struct fi
 	char *buf;
 
 	buf = kmalloc(count + 1, GFP_KERNEL);
-	if(buf == NULL) 
+	if(buf == NULL)
 		return(-ENOMEM);
 
 	if(copy_from_user(buf, buffer, count)){
@@ -661,7 +660,7 @@ static int notify_panic(struct notifier_
 
 	if(notify_socket == NULL) return(0);
 
-	mconsole_notify(notify_socket, MCONSOLE_PANIC, message, 
+	mconsole_notify(notify_socket, MCONSOLE_PANIC, message,
 			strlen(message) + 1);
 	return(0);
 }

